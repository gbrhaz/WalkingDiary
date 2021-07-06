//
//  UserLocationAuthorizing.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation
import CoreLocation


protocol UserLocationAuthorizing {

    var locationAuthorizationStatus: LocationAuthorizationStatus { get }

    func requestAlwaysAuthorization()

}


extension CLLocationManager: UserLocationAuthorizing {
    var locationAuthorizationStatus: LocationAuthorizationStatus {
        return LocationAuthorizationStatus(coreLocationStatus: CLLocationManager.authorizationStatus())
    }
}

