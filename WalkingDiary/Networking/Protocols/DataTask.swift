//
//  DataTask.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


protocol Resumeable: Cancellable {

    func resume()
    
}


extension URLSessionDataTask: Resumeable {}
