//
//  HttpRequest.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation

typealias HttpParameters = [String: Any]


struct HttpRequest {

    let url: URL
    let method: HttpMethod

    var parameters: HttpParameters?
    var headers: [String: String]
}


extension HttpRequest {

    func toURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return try method.encoding.encode(request: request, parameters: parameters)
    }

}
