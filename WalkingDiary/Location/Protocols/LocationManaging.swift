//
//  LocationManaging.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation
import CoreLocation


protocol LocationManaging: AnyObject, UserLocationAuthorizing {

    var pausesLocationUpdatesAutomatically: Bool { get set }

    var allowsBackgroundLocationUpdates: Bool { get set }

    var distanceFilter: CLLocationDistance { get set }

    var delegate: CLLocationManagerDelegate? { get set }

    var desiredAccuracy: Double { get set }

    func startUpdatingLocation()

    func stopUpdatingLocation()
}

extension CLLocationManager: LocationManaging {}
