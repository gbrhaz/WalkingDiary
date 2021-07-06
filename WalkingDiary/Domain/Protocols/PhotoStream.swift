//
//  PhotoStream.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation

protocol PhotoStream {

    func observeStreamChanged(callback: @escaping () -> Void)

    func observeErrors(callback: @escaping (Error) -> Void)

    func start()

    func stop()

}
