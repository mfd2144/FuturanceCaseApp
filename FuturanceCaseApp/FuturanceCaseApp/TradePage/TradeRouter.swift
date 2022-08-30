//
//  TradeRouter.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 27.08.2022.
//

import Foundation
import UIKit

final class TradeRouter: TradeRouterProtocol {
    weak var view: TradeViewProtocol?
    
    func routeToPage(_ routes: TradeRoutes) {
        switch routes {
        case .anyFeedback(let feedback):
            let alert = ShowFeedBack(feedback: feedback) { _ in }
            guard let controller = view as? UIViewController else { return }
            controller.present(alert.controller, animated: true)
        case.showWallet:
            var text = ""
            for entity in WalletManager.shared.myWallet.value.entities {
                text += "\(entity.name) --- \(entity.amount)\n"
            }
            let feedback = Feedback.info(text)
            let alert = ShowFeedBack(feedback: feedback) { _ in }
            guard let controller = view as? UIViewController else { return }
            controller.present(alert.controller, animated: true)
        }
    }
}
