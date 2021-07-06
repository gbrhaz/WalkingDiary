//
//  PhotoStream.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 10/05/2021.
//

import Foundation


/// Photo stream data source, keeps a collection of photos and potentially the data for the images if fetched.
class LocationBasedPhotoStream {

    private var items = [PhotoStreamItem]() {
        didSet {
            streamObservers.forEach { $0() }
        }
    }

    private let intermittentPhotoProvider: IntermittentPhotoProviding
    private let dataFetcher: DataFetching

    private var fetchCancellables = [IndexPath: Cancellable]()
    private var photoFetchCancellable: Cancellable?
    private var streamObservers = [() -> Void]()
    private var errorObservers = [(Error) -> Void]()

    init(
        intermittentPhotoProvider: IntermittentPhotoProviding,
        dataFetcher: DataFetching
    ) {
        self.intermittentPhotoProvider = intermittentPhotoProvider
        self.dataFetcher = dataFetcher
    }

}


extension LocationBasedPhotoStream: PhotoStream {

    func observeStreamChanged(callback: @escaping () -> Void) {
        streamObservers.append(callback)
    }

    func observeErrors(callback: @escaping (Error) -> Void) {
        errorObservers.append(callback)
    }

    func start() {
        items = []

        photoFetchCancellable = intermittentPhotoProvider.startFetchingPhotos { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorObservers.forEach { $0(error) }
            case .success(let photo):
                self?.items.insert(.init(photo: photo, imageData: nil), at: 0)
            }
        }
    }


    func stop() {
        photoFetchCancellable?.cancel()
        fetchCancellables.forEach { $0.value.cancel() }
    }
}


extension LocationBasedPhotoStream: PhotoStreamDataSource {

    func numberOfItems(inSection section: Int) -> Int {
        items.count
    }

    func imageData(at indexPath: IndexPath) -> Data? {
        item(at: indexPath).imageData
    }

    func photo(at indexPath: IndexPath) -> Photo? {
        item(at: indexPath).photo
    }

    func fetchImages(for indexPaths: [IndexPath]) {
        for path in indexPaths {
            let item = self.item(at: path)

            guard item.imageData == nil else { return }

            let cancellable = dataFetcher.fetch(dataAtURL: item.photo.url) { [weak self] result in
                guard let self = self else { return }

                // It would likely be worth retrying in some capacity here (if the http client doesn't already
                // do it); we shouldn't "worry" _too_ much about bubbling the error up from here as the system will
                // always attempt a re-fetch down the line.
                let imageData = try? result.get()
                if let index = self.items.firstIndex(of: item), let imageData = imageData {
                    self.items[index] = .init(photo: item.photo, imageData: imageData)
                }
            }

            fetchCancellables[path] = cancellable
        }

    }

    func cancelImageFetching(for indexPaths: [IndexPath]) {
        for path in indexPaths {
            fetchCancellables[path]?.cancel()
        }
    }


    private func item(at indexPath: IndexPath) -> PhotoStreamItem {
        items[indexPath.row]
    }

}
