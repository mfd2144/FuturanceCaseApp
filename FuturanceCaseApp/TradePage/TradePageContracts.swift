//
//  TradePageContracts.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

// View
protocol TradeViewProtocol: AnyObject {
    func handleOutputs(_ outputs: TradePresenterOutputs)
}
    
// Presenter

protocol TradePresenterProtocol: AnyObject {
    var view: TradeViewProtocol? { get set }
    
    func load()
    func buyPressed()
    func sellPressed()
    func refreshPressed()
    func mainButtonPressed()
    func cellSelected(_ currenctPresentation: CurrencyPresentation)
}

enum TradePresenterOutputs {
    case isLoading(Bool)
    case returnCurrenciesData([CurrencyPresentation])
    case anyError(String)
    case totalEntity(MyWallet)
    case afterSelectedButtonChange(SelectedButton)
    case afterCoinSelected(CurrencyPresentation)
}

// Interaction

protocol TradeInteractorProtocol: AnyObject {
    var presenter: TradeInteractorDelegate? { get set }
    
    func load()

}

protocol TradeInteractorDelegate: AnyObject {
    func handleInteractorOutputs(_ outputs: TradeInteractorOutputs)
}

enum TradeInteractorOutputs {
    case isLoading(Bool)
    case returnCurrenciesData([Currency])
    case returnOtherInformations([CurrencyOtherInformations])
    case anyError(FuturanceError)
    case totalEntity(MyWallet)
}
// Router
// We don't need router for this project

