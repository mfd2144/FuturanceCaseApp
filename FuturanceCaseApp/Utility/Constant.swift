//
//  Constant.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation
import UIKit

let buttonGreen: UIColor = UIColor(named: "buttonGreen") ?? .green
let buttonRed: UIColor = UIColor(named: "buttonRed") ?? .red
let navigationPurple = UIColor(named: "navigationPurple") ?? .purple
let background: UIColor = UIColor(named: "backgroundColor") ?? .gray
let lightGreen: UIColor = UIColor(named: "lightGreen") ?? .green
let darkGray: UIColor = UIColor(named: "darkGray") ?? .green
var topSafeArea: CGFloat {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    return windowScene?.windows.first?.safeAreaInsets.top ?? 0
}
var bottomSafeArea: CGFloat {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    return windowScene?.windows.first?.safeAreaInsets.bottom ?? 0
}
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
