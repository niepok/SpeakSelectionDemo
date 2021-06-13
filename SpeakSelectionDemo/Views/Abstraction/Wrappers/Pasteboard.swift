//
//  Pasteboard.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// An abstraction describing Pasteboard functionality.
protocol Pasteboard: AnyObject {
    /// String stored in pasteboard.
    var string: String? { get set }

    /// Image stored in pasteboard.
    var image: UIImage? { get set }
}

extension UIPasteboard: Pasteboard {}
