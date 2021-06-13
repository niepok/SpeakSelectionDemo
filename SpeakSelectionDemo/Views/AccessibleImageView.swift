//
//  AccessibleImageView.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// An accessible implementation of `UIImageView` with selection, copy and speak generation capabilities.
final class AccessibleImageView: UIImageView, SelectableView, ContentCopyableView, SpeakableView {

    /// SeeAlso: SelectableView.menuController
    let menuController: MenuController

    /// SeeAlso: SelectableView.menuActions
    var menuActions: [UIMenuItem] = makeMenuItems()

    /// SeeAlso: SelectableView.viewRect
    var viewRect: CGRect {
        bounds
    }

    /// SeeAlso: SelectableView.notificationCenter
    let notificationCenter: AppNotificationCenter

    /// SeeAlso: SelectableView.selectionOverlay
    let selectionOverlay: CALayer = makeSelectionOverlay()

    /// SeeAlso: ContentCopyableView.pasteboard
    let pasteboard: Pasteboard

    /// SeeAlso: SpeakableView.speechSynthesizer
    let speechSynthesizer: AppSpeechSynthesizer

    /// An app gesture factory.
    let appGestureFactory: AppGestureFactory

    /// SeeAlso: ContentCopyableView.content
    var content: CopyableContent? {
        guard let image = image else {
            return nil
        }
        return .image(image)
    }

    /// SeeAlso: SpeakableView.speakableDescription
    var speakableDescription: String {
        accessibilityLabel ?? ""
    }

    /// SeeAlso: UIView.canBecomeFirstResponder
    override var canBecomeFirstResponder: Bool {
        true
    }

    // MARK: - Initializer

    /// Default initializer for AccessibleImageView.
    ///
    /// - Parameters:
    ///     - menuController: a menu controller.
    ///     - notificationCenter: a notification center.
    ///     - pasteBoard: a paste board.
    ///     - speechSynthesizer: a speech synthesiser.
    ///     - appGestureFactory: an app gesture factory.
    init(
        menuController: MenuController = UIMenuController.shared,
        notificationCenter: AppNotificationCenter = NotificationCenter.default,
        pasteboard: Pasteboard = UIPasteboard.general,
        appSpeechSynthesizer: AppSpeechSynthesizer = DefaultAppSpeechSynthesizer(),
        appGestureFactory: AppGestureFactory = DefaultAppGestureFactory()
    ) {
        self.menuController = menuController
        self.notificationCenter = notificationCenter
        self.pasteboard = pasteboard
        self.speechSynthesizer = appSpeechSynthesizer
        self.appGestureFactory = appGestureFactory
        super.init(frame: .zero)
        setupViewSelection()
    }

    @available(*, unavailable, message: "Use init() instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// SeeAlso: UIView.layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionOverlay.frame = viewRect
    }

    /// SeeAlso: UIView.resignFirstResponder
    override func resignFirstResponder() -> Bool {
        menuController.hide(in: self, animated: true)
        return super.resignFirstResponder()
    }

    /// SeeAlso: SelectableView.startMenuNotificationMonitoring
    func startMenuNotificationMonitoring() {
        notificationCenter.addObserver(
            self,
            selector: #selector(didHideMenu),
            name: UIMenuController.didHideMenuNotification,
            object: nil
        )
    }

    /// SeeAlso: SelectableView.stopMenuNotificationMonitoring
    func stopMenuNotificationMonitoring() {
        notificationCenter.removeObserver(
            self,
            name: UIMenuController.didHideMenuNotification,
            object: nil
        )
    }

    /// SeeAlso: SelectableView.setupLongPressGestureRecognizer
    func setupLongPressGestureRecognizer() {
        addGestureRecognizer(appGestureFactory.make(gesture: .longPress, for: self, with: #selector(didLongPress)))
    }
}

// MARK: - Implementation details

private extension AccessibleImageView {

    // MARK: - Selectors

    @objc func didLongPress() {
        becomeFirstResponder()
        menuController.show(in: self, animated: true)
    }

    @objc func didHideMenu() {
        selectionOverlay.isHidden = true
    }

    @objc func copyImage() {
        menuController.hide(in: self, animated: true)
        copyContent()
    }

    @objc func speakImage() {
        menuController.hide(in: self, animated: true)
        speakContent()
    }

    // MARK: - Factory methods

    static func makeSelectionOverlay() -> CALayer {
        let layer = CALayer()
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.black.withAlphaComponent(0.14).cgColor
        layer.isHidden = true
        return layer
    }

    static func makeMenuItems() -> [UIMenuItem] {
        let copyItem = UIMenuItem(title: Strings.General.copy, action: #selector(copyImage))
        let speakItem = UIMenuItem(title: Strings.General.speak, action: #selector(speakImage))
        return [copyItem, speakItem]
    }
}
