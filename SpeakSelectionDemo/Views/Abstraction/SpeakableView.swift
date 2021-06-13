//
//  SpeakableView.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import UIKit

/// An abstraction describing view able to be spoken.
protocol SpeakableView: UIView {

    /// A description for speech synthesizer.
    var speakableDescription: String { get }

    /// A speech synthesizer.
    var speechSynthesizer: AppSpeechSynthesizer { get }

    /// Speak the content of the view.
    func speakContent()
}

// MARK: - Implementation details

extension SpeakableView {

    /// SeeAlso: SpeakableView.speakContent()
    func speakContent() {
        speechSynthesizer.speak(text: speakableDescription)
    }
}


