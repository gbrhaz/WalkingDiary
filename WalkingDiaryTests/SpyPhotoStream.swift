//
//  SpyPhotoStream.swift
//  WalkingDiaryTests
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation
@testable import WalkingDiary


class SpyPhotoStream: StubPhotoStream {
    enum Action: Equatable {
        case started
        case stopped
    }

    private(set) var actions = [Action]()

    override func start() {
        actions.append(.started)
    }

    override func stop() {
        actions.append(.stopped)
    }
}

