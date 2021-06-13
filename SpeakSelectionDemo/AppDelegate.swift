//
//  AppDelegate.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 12/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var flowCoordinator: BankAccountFlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        makeAndPresentRootViewController()
        return true
    }
}

// MARK: - Implementation details

private extension AppDelegate {

    func makeAndPresentRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = makeRootNavigationController()
        flowCoordinator = BankAccountFlowCoordinator(presentingNavigationController: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        flowCoordinator?.start()
    }

    func makeRootNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}

