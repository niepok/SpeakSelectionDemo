//
//  AudioSession.swift
//  SpeakSelectionDemo
//
//  Created by Adam Niepokój on 13/06/2021.
//

import AVFoundation

/// A protocol describing audio session.
protocol AudioSession: AnyObject {

    /// Sets the audio session’s category, mode, and options.
    ///
    /// - Parameters:
    ///     - category: the category to apply to the audio session. See `AVAudioSession.Category` for supported category values.
    ///     - mode: the audio session mode to apply to the audio session. For a list of values, see `AVAudioSession.Mode`.
    ///     - options: a mask of additional options for handling audio. For a list of constants, see `AVAudioSession.CategoryOptions`.
    func setCategory(
        _ category: AVAudioSession.Category,
        mode: AVAudioSession.Mode,
        options: AVAudioSession.CategoryOptions
    ) throws
}

extension AVAudioSession: AudioSession {}
