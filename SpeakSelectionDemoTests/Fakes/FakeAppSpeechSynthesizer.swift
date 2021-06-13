//
//  FakeAppSpeechSynthesizer.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import AVFoundation
import Mimus
@testable import SpeakSelectionDemo

final class FakeAppSpeechSynthesizer: AppSpeechSynthesizer, Mock {

    var storage = Storage()

    func speak(text: String) {
        recordCall(withIdentifier: "speak", arguments: [text])
    }
}
