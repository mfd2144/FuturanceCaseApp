//
//  SelectedButton.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 25.08.2022.
//

import Foundation
import class UIKit.UIColor

enum SelectedButton {
    case buy
    case sell
    
    var color: UIColor {
        switch self {
        case .buy:
            return buttonGreen
        case .sell:
            return buttonRed
        }
    }
}
