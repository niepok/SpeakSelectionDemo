//
//  FakeAudioSession.swift
//  SpeakSelectionDemoTests
//
//  Created by Adam Niepokój on 13/06/2021.
//

import AVFoundation
import Mimus
@testable import SpeakSelectionDemo

final class FakeAudioSession: AudioSession, Mock {

    var storage = Storage()

    func setCategory(_ category: AVAudioSession.Category, mode: AVAudioSession.Mode, options: AVAudioSession.CategoryOptions) throws {
        recordCall(withIdentifier: "setCategory")
    }
}
