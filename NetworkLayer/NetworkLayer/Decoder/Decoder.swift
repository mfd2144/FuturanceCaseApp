//
//  Decode.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

enum Decoders {
    static var plainDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
