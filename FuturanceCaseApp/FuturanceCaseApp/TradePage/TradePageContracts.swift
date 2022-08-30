//
//  TradePageContracts.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation
import struct NetworkLayer.CurrencyOtherInformations
import struct NetworkLayer.Currency

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
    func mainButtonPressed(to selectedCurrency: CurrencyPresentation,
                           for amount: Double,
                           by button: SelectedButton)
    func cellSelected(_ currenctPresentation: CurrencyPresentation)
    func showFeedback(_ feedback: Feedback)
    func showWallet()
}

enum TradePresenterOutputs {
    case isLoading(Bool)
    case returnCurrenciesData([CurrencyPresentation])
    case feedbackToView(Feedback)
    case afterSelectedButtonChange(SelectedButton)
    case afterCoinSelected(CurrencyPresentation)
    case walletChange
}

// Interaction

protocol TradeInteractorProtocol: AnyObject {
    var presenter: TradeInteractorDelegate? { get set }
    
    func load()
    func refresh()
    func mainButtonPressed(_ entity: Entity, for rate: Double, button: SelectedButton)
}

protocol TradeInteractorDelegate: AnyObject {
    func handleInteractorOutputs(_ outputs: TradeInteractorOutputs)
}

enum TradeInteractorOutputs {
    case isLoading(Bool)
    case returnCurrenciesData([Currency])
    case returnOtherInformations([CurrencyOtherInformations])
    case feedbackToPresenter(Feedback)
    case walletChange

}
// Router

protocol TradeRouterProtocol: AnyObject {
    func routeToPage(_ routes: TradeRoutes)
}

enum TradeRoutes {
    case anyFeedback(Feedback)
    case showWallet
}
