//
//  ViewController.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/052021.
//

import UIKit


class WalkViewController: UIViewController {

    private enum Constant {
        static let defaultPhotoSize: CGFloat = 400
    }

    private let viewModel: WalkViewModel
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let photoSize: CGFloat

    private lazy var item: UIBarButtonItem = {
        UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(startStopButtonTapped(_:)))
    }()

    init(viewModel: WalkViewModel, photoSize: CGFloat = Constant.defaultPhotoSize) {
        self.viewModel = viewModel
        self.photoSize = photoSize

        super.init(nibName: nil, bundle: nil)

        viewModel.observeChanges { [weak self] in
            self?.updateView()
        }

        viewModel.observeErrors { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: { _ in }))
            self?.present(alert, animated: true, completion: nil)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = item

        view.addSubviewFillingSuperview(tableView)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = photoSize
        tableView.estimatedRowHeight = photoSize

        updateView()
    }

    func updateView() {
        item.title = viewModel.startStopButtonText
        tableView.reloadData()
    }

    @objc func startStopButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.startStop()
    }

}

extension WalkViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: WalkSegmentTableViewCell.self, for: indexPath)

        viewModel.fetchImages(for: [indexPath])

        if let imageData = viewModel.imageData(at: indexPath) {
            cell.configure(with: .init(imageData: imageData))
        }


        return cell
    }

}

extension WalkViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.fetchImages(for: indexPaths)
    }

    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        viewModel.cancelImageFetching(for: indexPaths)
    }

}
