//
//  HttpError.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


enum HttpError: Error {
    case badRequest
    case serverError
    case invalidResponse
    case parseFailure
}
