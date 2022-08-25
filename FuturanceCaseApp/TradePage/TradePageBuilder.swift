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
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        return view
    }
}
