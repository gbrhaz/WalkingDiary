//
//  WalkingDiaryTests.swift
//  WalkingDiaryTests
//
//  Created by Harry Richardson on 08/05/2021.
//

import XCTest
@testable import WalkingDiary

class WalkViewModelTests: XCTestCase {

    private var subject: WalkViewModel!
    private var photoStream: SpyPhotoStream!

    override func setUp() {
        super.setUp()
        photoStream = .init()
        subject = WalkViewModel(photoStream: photoStream)
    }

    override func tearDown() {
        photoStream = nil
        subject = nil
        super.tearDown()
    }

    func testStartStop_StartsPhotoStream_WhenStopped() {
        subject.startStop()
        
        XCTAssertEqual(photoStream.actions, [.started])
    }

    func testStartStop_StopsPhotoStream_WhenStarted() {
        subject.startStop()
        subject.startStop()

        XCTAssertEqual(photoStream.actions, [.started, .stopped])
    }

    func testStartStopButtonText_Initial() {
        XCTAssertEqual(subject.startStopButtonText, "Start")
    }

    func testStartStopButtonText_WhenStarted() {
        subject.startStop()
        XCTAssertEqual(subject.startStopButtonText, "Stop")
    }

}
