//
//  ImageService.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation


/// Simple wrapper around the http client that also showcases one kind of caching (can be replaced with disk cache as well, which would be beneficial
/// if the memory usage could increase to dangerous levels)
class DataFetcher {

    private let httpClient: HttpClient
    private let cache: NSCache<NSString, NSData> = .init()

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

}

extension DataFetcher: DataFetching {

    func fetch(dataAtURL url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable {
        let cacheKey = NSString(string: url.absoluteString)

        if let cachedData = cache.object(forKey: cacheKey) {
            completion(.success(cachedData as Data))
            return DummyCancellable()
        } else {
            let request = HttpRequest(url: url, method: .get, parameters: nil, headers: [:])

            return httpClient.execute(request: request) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    completion(.success(response.data))
                    self.cache.setObject(response.data as NSData, forKey: cacheKey)
                }
            }
        }
    }

}
