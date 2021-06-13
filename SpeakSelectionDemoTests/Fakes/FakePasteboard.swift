//
//  FakePasteboard.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit
@testable import SpeakSelectionDemo

final class FakePasteboard: Pasteboard {
    var string: String?
    var image: UIImage?
}
