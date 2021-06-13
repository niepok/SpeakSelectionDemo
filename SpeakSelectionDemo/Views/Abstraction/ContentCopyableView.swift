//
//  ContentCopyableView.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// An enum describing content possible to be copied.
enum CopyableContent {
    case string(String)
    case image(UIImage)
}

/// An abstraction describing view with copyable content.
protocol ContentCopyableView: UIView {

    /// A pasteboard.
    var pasteboard: Pasteboard { get }

    /// A copyable content of the view.
    var content: CopyableContent? { get }

    /// Copies view content.
    func copyContent()
}

// MARK: - Implementation details

extension ContentCopyableView {

    /// SeeAlso: ContentCopyableView.copyContent()
    func copyContent() {
        guard let content = content else {
            return
        }
        switch content {
        case let .string(string):
            pasteboard.string = string
        case let .image(image):
            pasteboard.image = image
        }
    }
}
