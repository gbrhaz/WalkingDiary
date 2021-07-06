//
//  StubPhotoStream.swift
//  WalkingDiaryTests
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation
@testable import WalkingDiary


class StubPhotoStream: PhotoStream, PhotoStreamDataSource {

    func fetchImages(for indexPaths: [IndexPath]) {

    }

    func imageData(at indexPath: IndexPath) -> Data? {
        return nil
    }

    func numberOfItems(inSection section: Int) -> Int {
        return 0
    }

    func observeErrors(callback: @escaping (Error) -> Void) {

    }

    func observeStreamChanged(callback: @escaping () -> Void) {

    }

    func photo(at indexPath: IndexPath) -> Photo? {
        return nil
    }

    func start() {

    }

    func stop() {

    }

    func cancelImageFetching(for indexPaths: [IndexPath]) {

    }
}
