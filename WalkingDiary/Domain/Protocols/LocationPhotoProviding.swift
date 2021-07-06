//
//  LocationPhotoProviding.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation


protocol LocationPhotoProviding {

    func providePhoto(
        longitude: Double,
        latitude: Double,
        radius: Distance,
        completion: @escaping (Result<URL, Error>) -> Void
    ) -> Cancellable

}
