//
//  FlickrPhotosResponse.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


struct FlickrPhotosSearch: Codable {
    let total: Int
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [FlickrPhoto]
}
