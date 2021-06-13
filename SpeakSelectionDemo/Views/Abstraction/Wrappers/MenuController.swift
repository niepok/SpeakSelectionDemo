//
//  MenuController.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// An abstraction describing menu controller.
protocol MenuController: AnyObject {

    /// A flag determining if menu is visible.
    var isMenuVisible: Bool { get }

    /// Menu items.
    var menuItems: [UIMenuItem]? { get set }

    /// Sets the area in a view above or below which the editing menu is positioned.
    ///
    /// - Parameters:
    ///    - menuVisible: true if the menu should be shown, false if it should be hidden.
    ///    - animated: true if the showing or hiding of the menu should be animated, otherwise false.
    func setTargetRect(_ targetRect: CGRect, in targetView: UIView)

    /// Shows or hides the editing menu, optionally animating the action.
    /// - Parameters:
    ///     - targetRect: a rectangle that defines the area that is to be the target of the menu commands.
    ///     - targetView: the view in which targetRect appears.
    func setMenuVisible(_ menuVisible: Bool, animated: Bool)
}

extension UIMenuController: MenuController {}

// MARK: - Implementation details

extension MenuController {

    /// Shows menu controller for selectable view.
    ///
    /// - Parameters:
    ///     - selectableView: a selectable view.
    ///     - animated: a animation flag.
    func show(
        in selectableView: SelectableView,
        animated: Bool
    ) {
        guard !isMenuVisible else { return }
        selectableView.selectionOverlay.isHidden = false
        menuItems = selectableView.menuActions
        setTargetRect(selectableView.viewRect, in: selectableView)
        setMenuVisible(true, animated: animated)
    }

    /// Hides menu controller for selectable view.
    ///
    /// - Parameters:
    ///     - selectableView: a selectable view.
    ///     - animated: a animation flag.
    func hide(
        in selectableView: SelectableView,
        animated: Bool
    ) {
        guard isMenuVisible else { return }
        selectableView.selectionOverlay.isHidden = true
        menuItems = nil
        setMenuVisible(false, animated: animated)
    }
}
