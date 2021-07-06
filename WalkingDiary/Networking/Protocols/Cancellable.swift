//
//  Cancellable.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation

protocol Cancellable: AnyObject {
    
    func cancel()

}

extension URLSessionDataTask: Cancellable {}


class CompositeCancellable: Cancellable {

    private var cancellables = [Cancellable]()

    func cancel() {
        cancellables.forEach { $0.cancel() }
    }


    func append(_ cancellable: Cancellable) {
        cancellables.append(cancellable)
    }

}
