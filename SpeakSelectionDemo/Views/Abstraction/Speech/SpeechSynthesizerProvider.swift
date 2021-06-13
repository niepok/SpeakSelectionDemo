//
//  SpeechSynthesizerProvider.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import AVFoundation

/// A protocol describing speech synthesise.
protocol SpeechSynthesizer: AnyObject {
    /// A Boolean value indicating whether speech synthesiser is speaking.
    var isSpeaking: Bool { get }

    /// Enqueues an utterance to be spoken.
    ///
    /// - Parameter utterance: an AVSpeechUtterance object containing text to be spoken.
    func speak(_ utterance: AVSpeechUtterance)

    /// Stops all speech at the specified boundary constraint.
    ///
    /// - Parameter boundary: a constant describing whether speech should stop immediately or only after finishing the word currently being spoken.
    func stopSpeaking(at boundary: AVSpeechBoundary) -> Bool
}

extension AVSpeechSynthesizer: SpeechSynthesizer {}

/// A protocol describing speech synthesizer provider.
protocol SpeechSynthesizerProvider: AnyObject {

    /// Makes speech synthesizer.
    func makeSpeechSynthesizer() -> SpeechSynthesizer
}

final class DefaultSpeechSynthesizerProvider: SpeechSynthesizerProvider {

    /// SeeAlso: SpeechSynthesizerProvider.makeSpeechSynthesizer()
    func makeSpeechSynthesizer() -> SpeechSynthesizer {
        AVSpeechSynthesizer()
    }
}
