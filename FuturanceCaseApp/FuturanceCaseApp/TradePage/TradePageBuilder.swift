//
//  TradePageBuilder.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation
import UIKit

final class TradePageBuilder {
    static func make() -> UIViewController {
        let view = TradeView()
        let presenter = TradePresenter()
        let interactor = TradeInteractor()
        let router = TradeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        presenter.interactor = interactor
        router.view = view
        return view
    }
}
