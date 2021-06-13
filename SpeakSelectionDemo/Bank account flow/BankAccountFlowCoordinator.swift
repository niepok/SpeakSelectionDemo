//
//  BankAccountFlowCoordinator.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 12/06/2021.
//

import UIKit

/// A bank account flow coordinator.
final class BankAccountFlowCoordinator {

    // MARK: Properties

    /// A navigation controller to present the flow on.
    private(set) var presentingNavigationController: UINavigationController?

    // MARK: Initializers

    /// A default initializer for flow coordinator.
    ///
    /// - Parameters:
    ///   - presentingNavigationController: a navigation controller to present the flow on.
    init(presentingNavigationController: UINavigationController) {
        self.presentingNavigationController = presentingNavigationController
    }

    // MARK: Public methods

    /// Starts the flow coordinator.
    func start() {
        showBankAccountScreen()
    }
}

// MARK: - BankAccountViewControllerDelegate

extension BankAccountFlowCoordinator: BankAccountViewControllerDelegate {
    func viewControllerDidTriggerProceed(_ viewController: BankAccountViewController, from mode: BankAccountView.Mode) {
        switch mode {
        case .regular:
            showBlurredBankAccountScreen()
        case .inaccessible:
            showAccessibleBankAccountScreen()
        case .accessible:
            return
        }
    }
}

// MARK: - Implementation details

private extension BankAccountFlowCoordinator {

    func showBankAccountScreen() {
        let viewController = BankAccountViewController(mode: .regular)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: false)
    }

    func showBlurredBankAccountScreen() {
        let viewController = BankAccountViewController(mode: .inaccessible)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: true)
    }

    func showAccessibleBankAccountScreen() {
        let viewController = BankAccountViewController(mode: .accessible)
        viewController.delegate = self
        presentingNavigationController?.pushViewController(viewController, animated: true)
    }
}
