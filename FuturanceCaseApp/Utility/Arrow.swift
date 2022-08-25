//
//  enum Arrow.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import Foundation
import UIKit

enum Arrow {
    case upArrow
    case downArrow
}
extension Arrow {
    var image: UIImage {
        switch self {
        case .upArrow:
            return UIImage(systemName: "arrowtriangle.up.fill")!.withTintColor(buttonGreen, renderingMode: .alwaysOriginal).withAlignmentRectInsets(.init(top: -6, left: 0, bottom: -8, right: 0))

        case .downArrow:
            return UIImage(systemName: "arrowtriangle.down.fill")!.withTintColor(buttonRed, renderingMode: .alwaysOriginal).withAlignmentRectInsets(.init(top: -6, left: 0, bottom: -8, right: 0))
        }
    }
    var color: UIColor {
        switch self {
        case .upArrow:
            return buttonGreen
        case .downArrow:
            return buttonRed
        }
    }
}
