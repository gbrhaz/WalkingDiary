//
//  WalkViewModel.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation

class WalkViewModel {

    private enum Constant {
        static let stopText = "Stop"
        static let startText = "Start"
    }

    var startStopButtonText: String {
        isRunning ? Constant.stopText : Constant.startText
    }

    private var isRunning = false {
        didSet {
            observers.forEach { $0() }
        }
    }

    private var observers = [() -> Void]()
    private let photoStream: PhotoStreamDataSource & PhotoStream

    init(photoStream: PhotoStreamDataSource & PhotoStream) {
        self.photoStream = photoStream
    }

    func startStop() {
        isRunning ? stop() : start()
    }

    func observeChanges(callback: @escaping () -> Void) {
        photoStream.observeStreamChanged(callback: callback)

        observers.append(callback)
    }

    func observeErrors(callback: @escaping (Error) -> Void) {
        photoStream.observeErrors(callback: callback)
    }

    func fetchImages(for indexPaths: [IndexPath]) {
        photoStream.fetchImages(for: indexPaths)
    }

    func cancelImageFetching(for indexPaths: [IndexPath]) {
        photoStream.cancelImageFetching(for: indexPaths)
    }

    func imageData(at indexPath: IndexPath) -> Data? {
        photoStream.imageData(at: indexPath)
    }

    func numberOfItems(inSection section: Int) -> Int {
        photoStream.numberOfItems(inSection: section)
    }

    private func start() {
        photoStream.start()
        isRunning = true
    }

    private func stop() {
        photoStream.stop()
        isRunning = false
    }

}
