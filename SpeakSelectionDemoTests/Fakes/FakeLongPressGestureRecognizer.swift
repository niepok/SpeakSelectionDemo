//
//  FakeLongPressGestureRecognizer.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

final class FakeLongPressGestureRecognizer: UILongPressGestureRecognizer {

    let testTarget: AnyObject?
    let testAction: Selector?
    var testState: UIGestureRecognizer.State?

    init(target: AnyObject?, action: Selector?) {
        testTarget = target
        testAction = action
        super.init(target: target, action: action)
    }

    func performLongPress(
        numberOfTouches: Int = 1,
        pressDuration: TimeInterval = 1.0,
        state: UIGestureRecognizer.State? = nil
    ) {
        guard let selector = testAction else {
            return
        }
        testState = state
        _ = testTarget?.perform(selector, with: self)
    }
}
