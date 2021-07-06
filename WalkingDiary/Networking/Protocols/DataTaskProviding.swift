//
//  DataTaskProviding.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


protocol DataTaskProviding {

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Resumeable
    
}


extension URLSession: DataTaskProviding {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Resumeable {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
