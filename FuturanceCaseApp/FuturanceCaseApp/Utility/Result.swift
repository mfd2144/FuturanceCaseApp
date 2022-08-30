//
//  Result.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 30.08.2022.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case error(Error)
}
