//
//  FlickrPhoto.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


struct FlickrPhoto: Identifiable, Codable {

    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String

}
