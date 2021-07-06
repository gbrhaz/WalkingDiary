//
//  HttpClient.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


class DefaultHttpClient: HttpClient {

    private let session: DataTaskProviding

    init(session: DataTaskProviding = URLSession.shared) {
        self.session = session
    }

    func execute(request: HttpRequest, completion: @escaping (Result<HttpResponse, Error>) -> Void) -> Cancellable {

        let completeOnMain = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        do {
            let urlRequest = try request.toURLRequest()

            let task = session.dataTask(with: urlRequest) { data, response, error in
                guard let response = response as? HTTPURLResponse else {
                    completeOnMain(.failure(HttpError.invalidResponse))
                    return
                }

                if let error = error {
                    completeOnMain(.failure(error))
                    return
                }

                guard let data = data else {
                    completeOnMain(.failure(HttpError.invalidResponse))
                    return
                }

                completeOnMain(.success(.init(data: data, response: response)))
            }

            task.resume()

            return task
        } catch {
            completeOnMain(.failure(error))
            return DummyCancellable()
        }
    }
}

