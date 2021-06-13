//
//  SelectableView.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// An abstraction describing selectable view.
protocol SelectableView: UIView {

    /// A menu controller.
    var menuController: MenuController { get }

    /// Actions for menu controller.
    var menuActions: [UIMenuItem] { get }

    /// A rectangle of the view.
    var viewRect: CGRect { get }

    /// A notification center.
    var notificationCenter: AppNotificationCenter { get }

    /// An overlay selection layer.
    var selectionOverlay: CALayer { get }

    /// Setups view selection.
    func setupViewSelection()

    /// Setups long press gesture recognizer.
    func setupLongPressGestureRecognizer()

    /// Starts menu notification monitoring.
    func startMenuNotificationMonitoring()

    /// Stops menu notification monitoring.
    func stopMenuNotificationMonitoring()
}

// MARK: - Implementation details

extension SelectableView {

    /// SeeAlso: SelectableView.setupViewSelection()
    func setupViewSelection() {
        layer.addSublayer(selectionOverlay)
        isUserInteractionEnabled = true
        setupLongPressGestureRecognizer()
        startMenuNotificationMonitoring()
    }
}
