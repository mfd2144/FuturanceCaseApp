//
//  TradePresenter.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

final class TradePresenter: TradePresenterProtocol {
    weak var view: TradeViewProtocol?
    var interactor: TradeInteractorProtocol!
    var counter = 1
    private var currencyPresentations: [CurrencyPresentation]?
    private var  otherInformations: [CurrencyOtherInformations]?
    
    func load() {
        interactor.load()
    }
    
    func buyPressed(for qty: Double, from currecyType: String) {
        print("buy")
    }
    
    func sellPressed(for qty: Double, to currecyType: String) {
        print("sell")
        view?.handlePresenterOutputs(.anyError("sell return"))
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
            view?.handlePresenterOutputs(.returnCurrenciesData(currencyPresentations!))
        } else {
            // other information wasn't fetched yet
            view?.handlePresenterOutputs(.returnCurrenciesData(currencyPresentations!))
        }

    }
}
extension TradePresenter: TradeInteractorDelegate {
    func handleInteractorOutputs(_ outputs: TradeInteractorOutputs) {
        switch outputs {
        case .isLoading(let loading):
            print(loading)
        case .returnCurrenciesData(let currencies):
            var presentation = [CurrencyPresentation]()
            currencies.forEach {
                do {
                    let model = try CurrencyPresentation($0)
                    presentation.append(model)
                } catch {
                    view?.handlePresenterOutputs(.anyError((error as? FuturanceError)!.localDescription))
                }
            }
            currencyPresentations = presentation
            bindData()
        case .anyError(let string):
            break
        case .totalEntity(let dictionary):
            break
        case .returnOtherInformations(let informations):
            self.otherInformations = informations
            bindData()
        }
    }
}
