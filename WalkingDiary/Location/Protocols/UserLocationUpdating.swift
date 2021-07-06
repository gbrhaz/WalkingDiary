//
//  UserLocationUpdating.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation
import CoreLocation

typealias LocationUpdated = ((Result<Location, LocationError>) -> Void)

protocol UserLocationUpdating {

    func getUpdatedLocations(onLocationUpdated: @escaping LocationUpdated)

    func stopUpdatingLocations()

}
