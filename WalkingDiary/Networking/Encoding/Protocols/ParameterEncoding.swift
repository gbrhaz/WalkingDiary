//
//  ParameterEncoding.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


protocol ParameterEncoding {
    func encode(request: URLRequest, parameters: [String: Any]?) throws -> URLRequest
}
