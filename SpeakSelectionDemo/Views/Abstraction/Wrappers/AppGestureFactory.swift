//
//  AppGestureFactory.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// Gestures produced in `Gesture factory`
enum AppGesture {
    /// A long press gesture.
    case longPress
}

/// An abstraction describing gesture factory.
protocol AppGestureFactory: AnyObject {

    /// Makes a given type of gesture.
    ///
    /// - Parameters:
    ///     - gesture: type of gesture to be made.
    ///     - target: a target object.
    ///     - action: an action to be performed upon gesture.
    func make(
        gesture: AppGesture,
        for target: AnyObject?,
        with action: Selector?
    ) -> UIGestureRecognizer
}

/// Default implementation of `AppGestureFactory`.
final class DefaultAppGestureFactory: AppGestureFactory {

    /// SeeAlso: AppGestureFactory.make(gesture, target, action)
    func make(
        gesture: AppGesture,
        for target: AnyObject?,
        with action: Selector?
    ) -> UIGestureRecognizer {
        switch gesture {
        case .longPress:
            return UILongPressGestureRecognizer(target: target, action: action)
        }
    }
}
