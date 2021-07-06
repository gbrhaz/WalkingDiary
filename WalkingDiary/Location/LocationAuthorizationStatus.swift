//
//  LocationAuthorizationStatus.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation
import CoreLocation


enum LocationAuthorizationStatus {
    case notDetermined
    case restricted
    case denied
    case authorizedAlways
    case authorizedWhenInUse


    init(coreLocationStatus: CLAuthorizationStatus) {
        switch coreLocationStatus {
        case .authorizedAlways: self = .authorizedAlways
        case .authorizedWhenInUse: self = .authorizedWhenInUse
        case .denied: self = .denied
        case .notDetermined: self = .notDetermined
        case .restricted: self = .restricted
        @unknown default: self = .notDetermined
        }
    }
}
