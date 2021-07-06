//
//  ConfigurableCell.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation


protocol Configurable {

    associatedtype ItemData

    func configure(with _: ItemData)

}
