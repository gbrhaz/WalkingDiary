//
//  URLEncoding.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation

// Encoding helpfully provided by Alamofire:
// https://github.com/Alamofire/Alamofire/blob/master/Source/ParameterEncoding.swift


class URLEncoding: ParameterEncoding {

    private let boolEncoding: BoolEncoding

    init(boolEncoding: BoolEncoding = .numeric) {
        self.boolEncoding = boolEncoding
    }

    func encode(request: URLRequest, parameters: [String : Any]?) throws -> URLRequest {
        var request = request

        guard let parameters = parameters else {
            return request
        }

        if let _ = request.httpMethod {
            guard let url = request.url else {
                throw EncodingError.urlMissing
            }

            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                request.url = urlComponents.url
            }
        }

        return request
    }

    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }

        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }


    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        case let array as [Any]:
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        case let number as NSNumber:
            if number.isBool {
                components.append((escape(key), escape(boolEncoding.encode(value: number.boolValue))))
            } else {
                components.append((escape(key), escape("\(number)")))
            }
        case let bool as Bool:
            components.append((escape(key), escape(boolEncoding.encode(value: bool))))
        default:
            components.append((escape(key), escape("\(value)")))
        }
        return components
    }


    private func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? string
    }

}
