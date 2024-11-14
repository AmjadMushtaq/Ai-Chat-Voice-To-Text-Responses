//
//  SpeechToTextProtocol.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 05/11/2024.
//

import Foundation

protocol SpeechToTextServiceProtocol {
    func authorize() async throws
    func transcribe() -> AsyncThrowingStream<String, Error>
    func stopTranscribing()
}
