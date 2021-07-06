//
//  FlickrService.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/052021.
//

import Foundation


class FlickrPhotoService {

    private let client: FlickrClient
    
    init(client: FlickrClient) {
        self.client = client
    }

}


extension FlickrPhotoService: FlickrPhotoSearching {

    func search(parameters: PhotoSearchParameters, completion: @escaping (Result<[FlickrPhoto], Error>) -> Void) -> Cancellable { 
        return client.execute(method: .photosSearch, parameters: parameters.asURLParameters) { (result: Result<FlickrPhotosSearchResponse, Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.photos.photo))
            }
        }

    }

}


extension FlickrPhotoService: LocationPhotoProviding {

    func providePhoto(
        longitude: Double,
        latitude: Double,
        radius: Distance,
        completion: @escaping (Result<URL, Error>) -> Void
    ) -> Cancellable {

        let params = PhotoSearchParameters(
            longitude: longitude,
            latitude: latitude,
            sort: .interestingnessDescending,
            hasGeo: true,
            geoContext: .outdoors,
            accuracy: nil,
            contentType: nil,
            media: nil,
            radius: Distance(value: radius.metres * 0.001, unit: .kilometres)
        )

        return search(parameters: params) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let photos):
                guard let topPhoto = photos.first else {
                    completion(.failure(FlickrError.collectionEmpty))
                    return
                }

                let url = self.client.createPhotoURL(photo: topPhoto, size: .w)

                completion(.success(url))
            }
        }
    }

}
