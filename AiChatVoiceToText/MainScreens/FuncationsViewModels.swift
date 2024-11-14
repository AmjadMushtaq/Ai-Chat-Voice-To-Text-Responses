//
//  FuncationsViewModels.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 06/11/2024.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI

class FuncationsViewModels: ObservableObject {
    @Published var userPrompt: String = ""
    @Published var response: String = ""
    @Published var isLoading: Bool = false
    @Published var isRecording: Bool = false
    let model: GenerativeModel
    let speechToTextViewModel: SpeechToTextViewModel
    
    // MARK: - Initializer
    init(model: GenerativeModel, speechToTextViewModel: SpeechToTextViewModel) {
        self.model = model
        self.speechToTextViewModel = speechToTextViewModel
    }
    
    // MARK: - Hides Keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: - Recording Management
    @MainActor
    func toggleRecord() {
        if speechToTextViewModel.isRecording {
            speechToTextViewModel.stopRecording()
            userPrompt = speechToTextViewModel.transcript
            isRecording = false // Stop the animation
        } else {
            speechToTextViewModel.startRecording()
            isRecording = true // Start the animation
        }
    }
    
    
    // MARK: - Response Generation
    /// Generates a response based on the user prompt. Updates the response and loading state.
    /// - Throws: An error if the content generation fails.
    @MainActor
    func generateResponse() async {
        guard !userPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            response = "Please enter a prompt."
            print("User prompt is empty.")
            return
        }
        
        isLoading = true
        response = "" // Clear any previous response
        print("Generating response for prompt: \(userPrompt)")
        
        do {
            let result = try await model.generateContent(userPrompt)
            let generatedText = result.text ?? "No Response found"
            response = cleanUpGeneratedText(generatedText)
            print("Generated response: \(response)")
            
            userPrompt = "" // Clear prompt after generating response
        } catch {
            response = "Something went wrong: \(error.localizedDescription)"
            print("Error generating response: \(error)")
        }
        isLoading = false
    }

    // Helper method to clean up the generated text
    private func cleanUpGeneratedText(_ text: String) -> String {
        // Replace asterisks, bullets, and hash signs with an empty string
        let cleanedText = text
            .replacingOccurrences(of: "*", with: "")
//            .replacingOccurrences(of: "•", with: "•")
            .replacingOccurrences(of: "#", with: "")
        
        // Split the text into lines
        let lines = cleanedText.components(separatedBy: .newlines)
        
        let formattedLines = lines
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        // Join the formatted lines back together
        return formattedLines.joined(separator: "\n")
    }
}

