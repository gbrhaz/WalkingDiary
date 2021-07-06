//
//  Distance.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation


struct Distance {

    enum Unit: String {
        case miles = "mi"
        case metres = "m"
        case kilometres = "km"
    }

    let value: Double
    let unit: Unit

    var metres: Double {
        switch unit {
        case .kilometres: return value * 1000
        case .metres: return value
        case .miles: return value * 1609.34
        }
    }

    init(value: Double, unit: Unit) {
        self.value = value
        self.unit = unit
    }
}
