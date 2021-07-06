//
//  DataFetching.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 09/05/2021.
//

import Foundation


protocol DataFetching {

    func fetch(dataAtURL url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable

}
