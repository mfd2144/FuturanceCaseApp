//
//  AppContainer.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

let appContainer = AppContainer()

final class AppContainer {
    let manager = CurrencyManager()
    let router = AppRouter()
}
