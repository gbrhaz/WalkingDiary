//
//  FlickrClient.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


protocol FlickrClient {

    func execute<T: Decodable>(method: FlickrApiMethod, parameters: HttpParameters?, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable

    func createPhotoURL(photo: FlickrPhoto, size: FlickrPhotoSize) -> URL
}
