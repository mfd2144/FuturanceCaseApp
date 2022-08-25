//
//  TradePageContracts.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

// View

protocol TradeViewProtocol: AnyObject {
    func handlePresenterOutputs(_ outputs: TradePresenterOutputs)
}
    
// Presenter

protocol TradePresenterProtocol: AnyObject {
    var view: TradeViewProtocol? { get set }
    
    func load()
    func buyPressed(for qty: Double, from currecyType: String)
    func sellPressed(for qty: Double, to currecyType: String)
}

enum TradePresenterOutputs {
    case isLoading(Bool)
    case returnCurrenciesData([CurrencyPresentation])
    case anyError(String)
    case totalEntity([String: String])
}

// Interaction

protocol TradeInteractorProtocol: AnyObject {
    var presenter: TradeInteractorDelegate? { get set }
    
    func load()
    func buyPressed(for qty: Double, from currecyType: String)
    func sellPressed(for qty: Double, to currecyType: String)
}

protocol TradeInteractorDelegate: AnyObject {
    func handleInteractorOutputs(_ outputs: TradeInteractorOutputs)
}

enum TradeInteractorOutputs {
    case isLoading(Bool)
    case returnCurrenciesData([Currency])
    case returnOtherInformations([CurrencyOtherInformations])
    case anyError(FuturanceError)
    case totalEntity([String: String])
}
// Router
// We don't need router for this project

