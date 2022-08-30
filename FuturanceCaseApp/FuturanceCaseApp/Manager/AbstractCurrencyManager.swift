//
//  CurrencyManager.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 30.08.2022.
//

import Foundation
import NetworkLayer

final class AbstractCurrencyManager {
    let manager = CurrencyManager()
    
    func getImage(kind: CurrencyAPI, completion: @escaping (_ data: Data?, _ error: String?) -> Void) {
        manager.getImage(kind: kind, completion: completion)
    }
    func getCurrencyInformations(kind: CurrencyAPI, completion: @escaping (_ data: [CurrencyOtherInformations]?, _ error: String?) -> Void) {
        manager.getCurrencyInformations(kind: kind, completion: completion)
    }
    func getCurrencies(kind: CurrencyAPI, completion: @escaping (_ currency: [Currency]?, _ error: String?) -> Void) {
        manager.getCurrencies(kind: kind, completion: completion)
    }
}
