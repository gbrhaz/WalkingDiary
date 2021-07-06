//
//  FlickrPhotoSize.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


enum FlickrPhotoSize: String {
    case s = "s"
    case q = "q"
    case t = "t"
    case m = "m"
    case n = "n"
    case w = "w"


    var longestEdge: Int {
        switch self {
        case .s: return 75
        case .q: return 150
        case .t: return 100
        case .m: return 240
        case .n: return 320
        case .w: return 400
        }
    }
}
