//
//  HttpClient.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


protocol HttpClient {

    func execute(request: HttpRequest, completion: @escaping (Result<HttpResponse, Error>) -> Void) -> Cancellable
    
}
