//
//  OtherInfosResponses.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 25.08.2022.
//

import Foundation

struct CurrencyOtherInformationsResponse: Decodable {
    var result: [CurrencyOtherInformations]
    
    init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        result = try singleValueContainer.decode([CurrencyOtherInformations].self)
    }
}
