//
//  DefaultFlickrClient.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


final class DefaultFlickrClient: FlickrClient {

    private struct DefaultRequestParameters {
        let apiKey: String
        let format: String = "json"
        let noJsonCallback: Int = 1

        var asURLParameters: [String: Any] {
            [
                "api_key": apiKey,
                "format": format,
                "nojsoncallback": noJsonCallback
            ]
        }
    }


    private let httpClient: HttpClient
    private let defaultParameters: DefaultRequestParameters
    private let apiBaseURL: URL
    private let photosBaseURL: URL

    init(
        httpClient: HttpClient,
        apiBaseURL: URL = URL(string: "https://api.flickr.com/services/rest/")!,
        photosBaseURL: URL = URL(string: "https://live.staticflickr.com")!,
        apiKey: String
    ) {
        self.httpClient = httpClient
        self.apiBaseURL = apiBaseURL
        self.photosBaseURL = photosBaseURL
        self.defaultParameters = .init(apiKey: apiKey)
    }

    func execute<T: Decodable>(
        method: FlickrApiMethod,
        parameters: HttpParameters?,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable {

        var parameters = parameters

        parameters?["method"] = method.rawValue

        parameters?.merge(
            defaultParameters.asURLParameters,
            uniquingKeysWith: { current, _ in
                return current
            }
        )

        let request = HttpRequest(
            url: apiBaseURL,
            method: method.httpMethod,
            parameters: parameters,
            headers: ["Content-Type": "application/json"]
        )

        return httpClient.execute(request: request) {
            completion($0.tryParse())
        }
    }


    func createPhotoURL(photo: FlickrPhoto, size: FlickrPhotoSize) -> URL {
        var components = URLComponents(url: photosBaseURL, resolvingAgainstBaseURL: false)
        components?.path = "/\(photo.server)/\(photo.id)_\(photo.secret)_\(size.rawValue).jpg"
        return components?.url ?? photosBaseURL
    }

}


fileprivate extension Result where Success == HttpResponse {
    func tryParse<T: Decodable>() -> Result<T, Error> {
        switch self {
        case .success(let response):
            let decoder = JSONDecoder()
            do {
                return .success(try decoder.decode(T.self, from: response.data))
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
