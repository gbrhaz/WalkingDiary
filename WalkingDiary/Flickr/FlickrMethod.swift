//
//  FlickrMethod.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


enum FlickrApiMethod: String {
    case photosSearch = "flickr.photos.search"
}


extension FlickrApiMethod {

    var httpMethod: HttpMethod {
        switch self {
        case .photosSearch: return .get
        }
    }
    
}
