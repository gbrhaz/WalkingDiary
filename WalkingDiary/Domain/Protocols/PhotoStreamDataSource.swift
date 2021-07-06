//
//  PhotoStreamDataSource.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation

protocol PhotoStreamDataSource {

    func numberOfItems(inSection section: Int) -> Int

    func photo(at indexPath: IndexPath) -> Photo?

    func imageData(at indexPath: IndexPath) -> Data?

    func fetchImages(for indexPaths: [IndexPath])

    func cancelImageFetching(for indexPaths: [IndexPath])

}
