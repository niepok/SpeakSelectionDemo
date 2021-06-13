//
//  UIView+Extensions.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 12/06/2021.
//

import UIKit

extension UIView {

    /// Configures an existing view to not convert the autoresizing mask into constraints.
    /// - Returns: A configured view.
    @discardableResult func layoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    /// A type of layout for constraints to use.
    enum ConstraintsType {
        case edges(view: UIView), safeAreaLayout(view: UIView)

        /// SeeAlso: `UIView.topAnchor`
        var topAnchor: NSLayoutYAxisAnchor {
            switch self {
            case let .edges(view):
                return view.topAnchor
            case let .safeAreaLayout(view):
                return view.safeAreaLayoutGuide.topAnchor
            }
        }

        /// SeeAlso: `UIView.bottomAnchor`
        var bottomAnchor: NSLayoutYAxisAnchor {
            switch self {
            case let .edges(view):
                return view.bottomAnchor
            case let .safeAreaLayout(view):
                return view.safeAreaLayoutGuide.bottomAnchor
            }
        }

        /// SeeAlso: `UIView.leadingAnchor`
        var leadingAnchor: NSLayoutXAxisAnchor {
            switch self {
            case let .edges(view):
                return view.leadingAnchor
            case let .safeAreaLayout(view):
                return view.safeAreaLayoutGuide.leadingAnchor
            }
        }

        /// SeeAlso: `UIView.trailingAnchor`
        var trailingAnchor: NSLayoutXAxisAnchor {
            switch self {
            case let .edges(view):
                return view.trailingAnchor
            case let .safeAreaLayout(view):
                return view.safeAreaLayoutGuide.trailingAnchor
            }
        }
    }
}
