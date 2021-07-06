//
//  WalkSegmentTableViewCell.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 9/05/2021.
//

import Foundation
import UIKit


class WalkSegmentTableViewCell: UITableViewCell, ReuseIdentifiable {

    struct ViewModel {
        let imageData: Data
    }

    private enum Constant {
        static let imageInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    private let segmentImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()


    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForReuse() {
        segmentImageView.image = nil
    }

    private func setup() {
        selectionStyle = .none
        contentView.addSubviewFillingSuperview(segmentImageView, withInsets: Constant.imageInsets)
    }

}


extension WalkSegmentTableViewCell: Configurable {

    func configure(with viewModel: ViewModel) {
        segmentImageView.image = UIImage(data: viewModel.imageData)
    }

}
