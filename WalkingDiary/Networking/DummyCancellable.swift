//
//  DummyCancellable.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


// Empty cancellable to allow us to control method flow and do something synchronous instead of asynchronous
class DummyCancellable: Cancellable {
    func cancel() {}
}


