//
//  UITableView+ReuseIdentifiable.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation
import UIKit

extension UITableView {

   func register<T: ReuseIdentifiable>(_ type: T.Type) {
       self.register(type, forCellReuseIdentifier: T.reuseIdentifier)
   }

   func dequeueReusableCell<T: ReuseIdentifiable>(ofType type: T.Type, for indexPath: IndexPath) -> T {
       register(T.self)
       guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
           preconditionFailure("Could not dequeue reusable cell of type \(T.self) for indexPath \(indexPath)")
       }
       return cell
   }

}
