//
//  FakeAppGestureFactory.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit
import Mimus
@testable import SpeakSelectionDemo

final class FakeAppGestureFactory: AppGestureFactory, Mock {

    var storage = Storage()

    var lastCreatedGestures = [UIGestureRecognizer]()

    func make(gesture: AppGesture, for target: AnyObject?, with action: Selector?) -> UIGestureRecognizer {
        recordCall(withIdentifier: "make", arguments: [gesture, target])
        switch gesture {
        case .longPress:
            let gesture = FakeLongPressGestureRecognizer(target: target, action: action)
            lastCreatedGestures.append(gesture)
            return gesture
        }
    }
}
