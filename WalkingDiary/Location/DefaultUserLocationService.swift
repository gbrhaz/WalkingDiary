//
//  UserLocationService.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation
import CoreLocation

class DefaultUserLocationService: NSObject, UserLocationUpdating {

    private let locationManager: LocationManaging
    private let distanceFilter: Distance
    private var onLocationUpdated: LocationUpdated?

    init(locationManager: LocationManaging = CLLocationManager(), distanceFilter: Distance) {
        self.locationManager = locationManager
        self.distanceFilter = distanceFilter
    }

    func getUpdatedLocations(onLocationUpdated: @escaping LocationUpdated) {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.onLocationUpdated = onLocationUpdated

        switch locationManager.locationAuthorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        default:
            break
        }
    }

    func stopUpdatingLocations() {
        locationManager.stopUpdatingLocation()
        onLocationUpdated = nil
    }

    private func startUpdatingLocation() {
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.distanceFilter = distanceFilter.metres
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }

    // Should really handle when the user selects only "authorised when in use" since this can impact on the user's
    // experience (especially if they decide to put their phone in their pocket...)
    private func handleAuthorizationStatusChange() {
        switch locationManager.locationAuthorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        default:
            onLocationUpdated?(.failure(.failedAuthorization(locationManager.locationAuthorizationStatus)))
        }
    }

}

extension DefaultUserLocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }

        onLocationUpdated?(.success(userLocation))
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatusChange()
    }

}
