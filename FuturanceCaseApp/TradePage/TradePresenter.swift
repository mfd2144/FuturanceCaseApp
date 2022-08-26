//
//  TradePresenter.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation
import Combine

final class TradePresenter: TradePresenterProtocol {
    weak var view: TradeViewProtocol?
    var interactor: TradeInteractorProtocol!
    
    private var subscriptions = Set<AnyCancellable>()
    private let selectedButton = PassthroughSubject<SelectedButton, Never>()
    private let selectedCoin = PassthroughSubject<CurrencyPresentation, Never>()
    private var currencyPresentations: [CurrencyPresentation]?
    private var  otherInformations: [CurrencyOtherInformations]?
    
    deinit {
        subscriptions.removeAll()
    }
    
    func load() {
        setCombine()
        interactor.load()
    }
    
    func buyPressed() {
        selectedButton.send(.buy)
        print("buy")
    }
    
    func sellPressed() {
        selectedButton.send(.sell)
        print("sell")
 
    }
    func refreshPressed() {
        
    }
    func mainButtonPressed() {
        //        WalletManager.shared.buyEntity(entity:.init(name: "BTC", amount: 1), rate: 25){result in
        //            switch result{
        //            case.success(let successResult):
        //                print(successResult)
        //            case.error(let error):
        //                print((error as? FuturanceError)?.localDescription)
        //            }
        //
        //        }
    }
    func cellSelected(_ currenctPresentation: CurrencyPresentation) {
        selectedCoin.send(currenctPresentation)
    }
    private func bindData() {
        // 1. check first currency data from binance
        guard  currencyPresentations != nil else { return }
        // 2. check other information was fetched or not
        if let otherInformations = otherInformations {
            // other information was fetched
            currencyPresentations?.indices.forEach({ index in
                let key = currencyPresentations![index].symbolFrom.lowercased()
                let otherIndex = otherInformations.first(where: { $0.symbol.lowercased() == key })
                currencyPresentations?[index].image = otherIndex?.image
                currencyPresentations?[index].name = otherIndex?.name
            })
            view?.handleOutputs(.returnCurrenciesData(currencyPresentations!))
            guard let firstElement = currencyPresentations?.first else { return }
            self.selectedCoin.send(firstElement)
        } else {
            // other information wasn't fetched yet
            view?.handleOutputs(.returnCurrenciesData(currencyPresentations!))
            guard let firstElement = currencyPresentations?.first else { return }
            self.selectedCoin.send(firstElement)
        }

    }
}
extension TradePresenter: TradeInteractorDelegate {
    func handleInteractorOutputs(_ outputs: TradeInteractorOutputs) {
        switch outputs {
        case .isLoading(let loading):
            view?.handleOutputs(.isLoading(loading))
        case .returnCurrenciesData(let currencies):
            var presentation = [CurrencyPresentation]()
            currencies.forEach {
                do {
                    let model = try CurrencyPresentation($0)
                    presentation.append(model)
                } catch {
                    view?.handleOutputs(.anyError((error as? FuturanceError)!.localDescription))
                }
            }
            currencyPresentations = presentation
            bindData()
        case .anyError(let futuranceError):
            // check
            view?.handleOutputs(.anyError(futuranceError.localDescription))
        case .returnOtherInformations(let informations):
            self.otherInformations = informations
            bindData()
        case .totalEntity( let myWallet):
            view?.handleOutputs(.totalEntity(myWallet))
   
    } 
}
}
// MARK: - Combine Jobs
extension TradePresenter {
    private func setCombine() {
        selectedButton.sink { _ in
        } receiveValue: {[weak self] button in
            guard let self = self else { return }
            switch button {
            case.buy:
                self.view?.handleOutputs(.afterSelectedButtonChange(.buy))
            case.sell:
                self.view?.handleOutputs(.afterSelectedButtonChange(.sell))
            }
        }.store(in: &subscriptions)
        
        selectedCoin.sink { _ in
        } receiveValue: { [weak self]coin in
            guard let self = self else { return }
            self.view?.handleOutputs(.afterCoinSelected(coin))
        }.store(in: &subscriptions)
        
        WalletManager.shared.myWallet.sink { _ in } receiveValue: { wallet in
            print(wallet)
//            wallet.entities.forEach({
//                self.coinLabel.text?.append("\($0.amount) \($0.name) ")
//                
//            })
        }.store(in: &subscriptions)
        // preselect button
    }
}
