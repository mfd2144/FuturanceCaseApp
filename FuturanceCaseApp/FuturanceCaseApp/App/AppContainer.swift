//
//  AppContainer.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import Foundation

let appContainer = AppContainer()

final class AppContainer {
    let manager = AbstractCurrencyManager()
    let router = AppRouter()
}
