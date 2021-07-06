//
//  HttpMethod.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
}


extension HttpMethod {

    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding()
        }
    }
}

