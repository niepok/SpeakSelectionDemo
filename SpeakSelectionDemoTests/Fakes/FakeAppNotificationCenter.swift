//
//  FakeAppNotificationCenter.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import Foundation
import Mimus
@testable import SpeakSelectionDemo

final class FakeAppNotificationCenter: AppNotificationCenter, Mock {

    var storage = Storage()

    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        recordCall(withIdentifier: "addObserver", arguments: [observer, aName?.rawValue, anObject])
    }

    func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?) {
        recordCall(withIdentifier: "removeObserver", arguments: [observer, aName?.rawValue, anObject])
    }
}
