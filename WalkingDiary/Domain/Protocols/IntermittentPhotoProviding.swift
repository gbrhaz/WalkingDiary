//
//  IntermittentPhotoProviding.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import CoreLocation
import Foundation


typealias PhotoFetched = ((Result<Photo, Error>) -> Void)


protocol IntermittentPhotoProviding {

    func startFetchingPhotos(onPhotoFetched: @escaping PhotoFetched) -> Cancellable

    func stopFetchingPhotos()

}
