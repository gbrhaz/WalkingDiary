//
//  IntermittentPhotoProvider.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation


/// Fetches photos based on the user's location with a specified threshold
class UserLocationBasedIntermittentPhotoProvider: IntermittentPhotoProviding {

    private let locationService: UserLocationUpdating
    private let locationPhotoProvider: LocationPhotoProviding
    private let photoDistanceThreshold: Distance

    private var previousLocation: Location?
    private var cancellable = CompositeCancellable()

    init(
        locationService: UserLocationUpdating,
        locationPhotoProvider: LocationPhotoProviding,
        distanceThreshold: Distance
    ) {
        self.locationService = locationService
        self.locationPhotoProvider = locationPhotoProvider
        self.photoDistanceThreshold = distanceThreshold
    }

    func startFetchingPhotos(onPhotoFetched: @escaping PhotoFetched) -> Cancellable {
        locationService.getUpdatedLocations { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                onPhotoFetched(.failure(error))
            case .success(let location):
                if let previousLocation = self.previousLocation {
                    if location.distance(from: previousLocation) >= self.photoDistanceThreshold.metres {
                        self.fetchPhoto(location: location, onPhotoFetched: onPhotoFetched)
                    }
                } else {
                    self.fetchPhoto(location: location, onPhotoFetched: onPhotoFetched)
                }
            }
        }

        return cancellable
    }

    func stopFetchingPhotos() {
        locationService.stopUpdatingLocations()
        previousLocation = nil
    }

    private func fetchPhoto(location: Location, onPhotoFetched: @escaping PhotoFetched) {
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude

        let findPhotoCancellable = self.locationPhotoProvider.providePhoto(
            longitude: longitude,
            latitude: latitude,
            radius: photoDistanceThreshold
        ) { photoResult in
            switch photoResult {
            case .failure(let error):
                onPhotoFetched(.failure(error))
            case .success(let url):
                let photo = Photo(url: url, longitude: longitude, latitude: latitude)
                onPhotoFetched(.success(photo))

                // Only setting previous location on a successful photo fetch will mean
                // on occasions where no photo is found, the user can keep walking and eventually
                // get a new photo that is relevant
                self.previousLocation = location
            }
        }

        self.cancellable.append(findPhotoCancellable)
    }

}


