//
//  AppSpeechSynthesizer.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import AVFoundation

/// Abstraction describing speech synthesiser.
protocol AppSpeechSynthesizer: AnyObject {

    /// Speaks given string.
    ///
    /// - Parameter text: a text to be spoken.
    func speak(text: String)
}

/// A default implementation of AppSpeechSynthesizer.
final class DefaultAppSpeechSynthesizer: AppSpeechSynthesizer {

    /// An audio session.
    let audioSession: AudioSession

    /// A speech synthesiser provider.
    let speechSynthesizerProvider: SpeechSynthesizerProvider

    private weak var speechSynthesizer: SpeechSynthesizer?

    /// Default initializer of DefaultAppSpeechSynthesizer.
    ///
    /// - Parameters:
    ///     - audioSession: an audio session.
    ///     - speechSynthesizer: a speech synthesiser.
    init(
        audioSession: AudioSession = AVAudioSession.sharedInstance(),
        speechSynthesizerProvider: SpeechSynthesizerProvider = DefaultSpeechSynthesizerProvider()
    ) {
        self.audioSession = audioSession
        self.speechSynthesizerProvider = speechSynthesizerProvider
    }

    deinit {
        _ = speechSynthesizer?.stopSpeaking(at: .word)
        speechSynthesizer = nil
    }

    /// SeeAlso: AppSpeechSynthesizer.speak(text)
    func speak(text: String) {
        if let speechSynthesizer = speechSynthesizer {
            generateSpeech(for: text, with: speechSynthesizer)
        } else {
            let newSpeechSynthesizer = speechSynthesizerProvider.makeSpeechSynthesizer()
            speechSynthesizer = newSpeechSynthesizer
            generateSpeech(for: text, with: newSpeechSynthesizer)
        }
    }
}

// MARK: - Implementation details

private extension DefaultAppSpeechSynthesizer {

    func generateSpeech(for text: String, with synthesizer: SpeechSynthesizer) {
        try? audioSession.setCategory(.playback, mode: .spokenAudio, options: .duckOthers)
        if synthesizer.isSpeaking { _ = synthesizer.stopSpeaking(at: .word) }
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
    }
}
