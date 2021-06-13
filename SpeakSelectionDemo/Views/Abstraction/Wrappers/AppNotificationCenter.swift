//
//  AppNotificationCenter.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import Foundation

/// A notification center wrapper.
protocol AppNotificationCenter: AnyObject {

    /// SeeAlso: NotificationCenter.addObserver()
    func addObserver(
        _ observer: Any,
        selector aSelector: Selector,
        name aName: NSNotification.Name?,
        object anObject: Any?
    )

    /// SeeAlso: NotificationCenter.removeObserver()
    func removeObserver(
        _ observer: Any,
        name aName: NSNotification.Name?,
        object anObject: Any?
    )
}

extension NotificationCenter: AppNotificationCenter {}
