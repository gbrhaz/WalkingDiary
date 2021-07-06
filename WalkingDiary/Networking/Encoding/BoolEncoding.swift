//
//  BoolEncoding.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


enum BoolEncoding {
    
    case numeric
    case literal


    func encode(value: Bool) -> String {
        switch self {
        case .numeric:
            return value ? "1" : "0"
        case .literal:
            return value ? "true" : "false"
        }
    }
}


