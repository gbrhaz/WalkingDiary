//
//  ReuseIdentifiable.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation
import UIKit

protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
