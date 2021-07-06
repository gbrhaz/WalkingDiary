//
//  NSNumber+IsBool.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


extension NSNumber {
    var isBool: Bool {
        String(cString: objCType) == "c"
    }
}

