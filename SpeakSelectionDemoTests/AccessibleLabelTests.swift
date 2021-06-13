//
//  AccessibleLabelTests.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import XCTest
import UIKit
import Mimus
@testable import SpeakSelectionDemo

final class AccessibleLabelTests: XCTestCase {

    var sut: AccessibleLabel!
    var fakeMenuController: FakeMenuController!
    var fakePasteBoard: FakePasteboard!
    var fakeSpeechSynthesizer: FakeAppSpeechSynthesizer!
    var fakeNotificationCenter: FakeAppNotificationCenter!
    var fakeGestureFactory: FakeAppGestureFactory!

    override func setUp() {
        fakeMenuController = FakeMenuController()
        fakePasteBoard = FakePasteboard()
        fakeSpeechSynthesizer = FakeAppSpeechSynthesizer()
        fakeNotificationCenter = FakeAppNotificationCenter()
        fakeGestureFactory = FakeAppGestureFactory()
        sut = AccessibleLabel(
            menuController: fakeMenuController,
            notificationCenter: fakeNotificationCenter,
            pasteboard: fakePasteBoard,
            appSpeechSynthesizer: fakeSpeechSynthesizer,
            appGestureFactory: fakeGestureFactory
        )
    }

    func testInitialSetup() {
        XCTAssertTrue(sut.menuController === fakeMenuController, "Should use provided controller")
        XCTAssertTrue(sut.pasteboard === fakePasteBoard, "Should use provided controller")
        XCTAssertTrue(sut.speechSynthesizer === fakeSpeechSynthesizer, "Should use provided synthesizer")
        XCTAssertTrue(sut.notificationCenter === fakeNotificationCenter, "Should use provided notification center")
        XCTAssertTrue(sut.appGestureFactory === fakeGestureFactory, "Should use provided gesture factory")
        XCTAssertTrue(sut.canBecomeFirstResponder, "Should be able to become first responder")
        XCTAssertTrue(sut.selectionOverlay.isHidden, "Should init selection overlay hidden")
        XCTAssertEqual(sut.isUserInteractionEnabled, true)
        XCTAssertNotNil(sut.gestureRecognizers?.first(where: { $0.isKind(of: UILongPressGestureRecognizer.self) }))
        fakeNotificationCenter.verifyCall(
            withIdentifier: "addObserver",
            arguments: [sut, UIMenuController.didHideMenuNotification.rawValue, nil]
        )
    }

    func testResigningFirstResponder() {
        // given:
        fakeMenuController.simulatedIsMenuVisible = true
        sut.selectionOverlay.isHidden = false
        fakeMenuController.menuItems = [UIMenuItem(title: "", action: #selector(dummyMethod))]

        // when:
        _ = sut.resignFirstResponder()

        // then:
        fakeMenuController.verifyCall(withIdentifier: "setMenuVisible", arguments: [false, true])
        XCTAssertNil(fakeMenuController.menuItems, "Should clear items")
        XCTAssertTrue(sut.selectionOverlay.isHidden, "Should hide overlay")
    }

    func testStopingMonitoring() {
        // when:
        sut.stopMenuNotificationMonitoring()

        // then:
        fakeNotificationCenter.verifyCall(
            withIdentifier: "removeObserver",
            arguments: [sut, UIMenuController.didHideMenuNotification.rawValue, nil]
        )
    }

    func testLongPress() throws {
        // when:
        let fakeLongPressRecognizer = try XCTUnwrap(fakeGestureFactory.lastCreatedGestures[0] as? FakeLongPressGestureRecognizer)
        fakeLongPressRecognizer.performLongPress()

        // then:
        fakeMenuController.verifyCall(withIdentifier: "setMenuVisible", arguments: [true, true])
    }

    func testSelectingActions() throws {
        // given:
        let fixtureString = "fixture string"
        sut.text = fixtureString
        let fakeLongPressRecognizer = try XCTUnwrap(fakeGestureFactory.lastCreatedGestures[0] as? FakeLongPressGestureRecognizer)
        fakeLongPressRecognizer.performLongPress()

        // given:
        var item = try XCTUnwrap(fakeMenuController.menuItems?.first(where: { $0.title == Strings.General.copy }))
        var selector = try XCTUnwrap(item.action)

        // when:
        sut.perform(selector)

        // then:
        XCTAssertEqual(fakePasteBoard.string, fixtureString, "Should copy proper string")

        // when:
        fakeLongPressRecognizer.performLongPress()

        // given:
        item = try XCTUnwrap(fakeMenuController.menuItems?.first(where: { $0.title == Strings.General.speak }))
        selector = try XCTUnwrap(item.action)

        // when:
        sut.perform(selector)

        // then:
        fakeSpeechSynthesizer.verifyCall(withIdentifier: "speak", arguments: [fixtureString])
    }
}

extension UIView: Matcher {

    public func matches(argument: Any?) -> Bool {
        if let otherView = argument as? UIView {
            return otherView === self
        } else {
            return false
        }
    }
}

private extension AccessibleLabelTests {
    /// Discussion:
    /// Added for sake of `testResigningFirstResponder()`
    @objc func dummyMethod() {}
}
