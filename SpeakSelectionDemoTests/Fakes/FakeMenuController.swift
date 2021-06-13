//
//  FakeMenuController.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit
import Mimus
@testable import SpeakSelectionDemo

final class FakeMenuController: MenuController, Mock {
    var storage = Storage()

    var isMenuVisible: Bool {
        simulatedIsMenuVisible ?? false
    }

    var menuItems: [UIMenuItem]?

    var simulatedIsMenuVisible: Bool?

    func setTargetRect(_ targetRect: CGRect, in targetView: UIView) {
        recordCall(withIdentifier: "setTargetRect", arguments: [targetRect, targetView])
    }

    func setMenuVisible(_ menuVisible: Bool, animated: Bool) {
        recordCall(withIdentifier: "setMenuVisible", arguments: [menuVisible, animated])
    }
}
