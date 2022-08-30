//
//  CurrencyManager.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

public struct CurrencyManager {
    private let router: AlamofireServiceProtocol
    
    public init() {
        router = AlamofireService()
    }
    public func getCurrencies(kind: CurrencyAPI, completion: @escaping (_ currency: [Currency]?, _ error: String?) -> Void) {
        router.fetchData(kind) { result in
            switch result {
            case.error(let error):
                completion(nil, error.localizedDescription)
            case.success(let data):
                let decoder = Decoders.plainDecoder
                do {
                    let response = try decoder.decode(CurrencyResponse.self, from: data)
                    completion(response.result, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                    
                }
            }
        }
    }
    public func getCurrencyInformations(kind: CurrencyAPI, completion: @escaping (_ data: [CurrencyOtherInformations]?, _ error: String?) -> Void) {
        router.fetchData(kind) { result in
            switch result {
            case.error(let error):
                completion(nil, error.localizedDescription)
            case.success(let data):
                let decoder = Decoders.plainDecoder
                do {
                    let response = try decoder.decode(CurrencyOtherInformationsResponse.self, from: data)
                    completion(response.result, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                    
                }
            }
        }
    }
    public func getImage(kind: CurrencyAPI, completion: @escaping (_ data: Data?, _ error: String?) -> Void) {
        router.fetchData(kind) { result in
            switch result {
            case.error(let error):
                completion(nil, error.localizedDescription)
            case.success(let data):
                completion(data, nil)
            }
        }
    }
}
