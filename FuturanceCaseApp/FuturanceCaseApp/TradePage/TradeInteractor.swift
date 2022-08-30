//
//  TradeInteractor.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import Foundation
import Combine

final class TradeInteractor: TradeInteractorProtocol {
    
    weak var presenter: TradeInteractorDelegate?
    
    func load() {
        presenter?.handleInteractorOutputs(.isLoading(true))
        appContainer.manager.getCurrencies(kind: .binance) {[weak self] currency, error in
            guard let self = self else { return }
            self.presenter?.handleInteractorOutputs(.isLoading(false))
            if let error = error {
                let feedBack = Feedback.error(FuturanceError.fetchingOtherInformationsError(error).localDescription)
                self.presenter?.handleInteractorOutputs(.feedbackToPresenter(feedBack))
            } else {
                guard let currency = currency else { return } // todo caution
                // Filtered pairs which are include TRY
                let tryFilteredData = currency.filter({ $0.symbol.contains("TRY") })
                self.presenter?.handleInteractorOutputs(.returnCurrenciesData(tryFilteredData))
            }
        }
        appContainer.manager.getCurrencyInformations(kind: .gecko) { otherInformations, error in
            if let error = error {
                let feedBack = Feedback.error(FuturanceError.fetchingOtherInformationsError(error).localDescription)
                
                self.presenter?.handleInteractorOutputs(.feedbackToPresenter(feedBack))
            } else {
                guard let otherInformations = otherInformations else { return } // todo caution
                // Filtered pairs which are include TRY
                self.presenter?.handleInteractorOutputs(.returnOtherInformations(otherInformations))
            }
        }
    }
    
    func refresh() {
        appContainer.manager.getCurrencies(kind: .binance) {[weak self] currency, error in
            guard let self = self else { return }
            self.presenter?.handleInteractorOutputs(.isLoading(false))
            if let error = error {
                let feedBack = Feedback.error(FuturanceError.fetchingOtherInformationsError(error).localDescription)
                self.presenter?.handleInteractorOutputs(.feedbackToPresenter(feedBack))
            } else {
                guard let currency = currency else { return } // todo caution
                // Filtered pairs which are include TRY
                let tryFilteredData = currency.filter({ $0.symbol.contains("TRY") })
                self.presenter?.handleInteractorOutputs(.returnCurrenciesData(tryFilteredData))
            }
        }
    }
    func mainButtonPressed(_ entity: Entity, for rate: Double, button: SelectedButton) {
        presenter?.handleInteractorOutputs(.isLoading(true))
        switch button {
        case .buy:
            buy(entity, for: rate)
        case .sell:
            sell(entity, for: rate)
        }
    }
    
    private func sell(_ entity: Entity, for rate: Double) {
        WalletManager.shared.sellEntity(entity: entity, rate: rate) { result in
           handleResult(result: result)
        }
    }
    private func buy(_ entity: Entity, for rate: Double) {
        WalletManager.shared.buyEntity(entity: entity, rate: rate) { result in
            handleResult(result: result)
        }
    }
    private func handleResult(result: Result<String>) {
        presenter?.handleInteractorOutputs(.isLoading(false))
        switch result {
        case.error(let error):
            guard let error = error as? FuturanceError else { return }
            let feedback = Feedback.error(error.localDescription)
            presenter?.handleInteractorOutputs(.feedbackToPresenter(feedback))
        case .success(let resultString):
            let feedback = Feedback.success(resultString)
            presenter?.handleInteractorOutputs(.feedbackToPresenter(feedback))
            presenter?.handleInteractorOutputs(.walletChange)
        }
    }
    
}
