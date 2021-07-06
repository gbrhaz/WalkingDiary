//
//  FlickrPhotoSearching.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


protocol FlickrPhotoSearching {

    func search(
        parameters: PhotoSearchParameters,
        completion: @escaping (Result<[FlickrPhoto], Error>) -> Void
    ) -> Cancellable
}


