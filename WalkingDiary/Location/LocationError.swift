//
//  LocationError.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation


enum LocationError: Error {
    case failedAuthorization(LocationAuthorizationStatus)

}
