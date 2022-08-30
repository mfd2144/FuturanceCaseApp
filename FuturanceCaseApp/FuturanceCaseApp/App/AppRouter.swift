//
//  AppRouter.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 23.08.2022.
//

import UIKit

final class AppRouter {
    var window: UIWindow?
    
    func start(_ scene: UIWindowScene) {
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        let controller = TradePageBuilder.make()
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
