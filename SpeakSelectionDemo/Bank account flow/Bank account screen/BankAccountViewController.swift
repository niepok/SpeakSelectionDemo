//
//  BankAccountViewController.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 12/06/2021.
//

import UIKit

/// A delegate for `BankAccountViewController`.
protocol BankAccountViewControllerDelegate: AnyObject {
    /// Notifies delegate that view controller triggered proceed to next screen action.
    ///
    /// - Parameters:
    ///     - viewController: a view controller that triggered that action.
    ///     - mode: a mode in which view controller is running.
    func viewControllerDidTriggerProceed(_ viewController: BankAccountViewController, from mode: BankAccountView.Mode)
}

/// A bank account view controller.
final class BankAccountViewController: UIViewController {

    // MARK: Public Properties

    /// A view controller delegate.
    weak var delegate: BankAccountViewControllerDelegate?

    /// A custom view.
    let customView: BankAccountView

    // MARK: Initializers

    /// A default BankAccountViewController initializer.
    init(mode: BankAccountView.Mode) {
        customView = BankAccountView(mode: mode)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init(mode:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    /// - SeeAlso: UIViewController.loadView()
    override func loadView() {
        view = customView
        view.clipsToBounds = true
    }

    /// - SeeAlso: UIViewController.viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.BankAccountScreen.navbarTitle
        setupViewCallbacks()
    }
}

// MARK: - Implementation details

private extension BankAccountViewController {

    func setupViewCallbacks() {
        customView.onProceedTap = { [unowned self] in
            delegate?.viewControllerDidTriggerProceed(self, from: customView.mode)
        }
    }
}
