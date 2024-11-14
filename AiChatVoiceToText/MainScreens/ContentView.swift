
//
//  ContentView.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 04/11/2024.


// MARK: Used for Bold Headings
/*
import SwiftUI
import Lottie
import GoogleGenerativeAI

struct ContentView: View {
    @State private var showMenu: Bool = false
    @State private var selectedTab: Int = 0
    @State private var userHasInteracted = false
    @State private var isBlinking = false
    @State private var isPressed = false
    @State private var showSheet = false
    @State private var selectedPrompt: String = ""
    @State private var userQuestion: String = ""
    @State private var copyMessage: String = ""
    
    // MARK: - State and ViewModel
    @StateObject private var viewModel = FuncationsViewModels(
        model: GenerativeModel(name: "gemini-pro", apiKey: APIKey.default),
        speechToTextViewModel: SpeechToTextViewModel(speechToTextService: SpeechToTextService())
    )
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Header
                Text("AI Personal Assistant")
                    .font(.title)
                    .bold()
                
                // MARK: - Response Display
                ZStack {
                    ScrollView {
                        
                        // User Question
                        if !userQuestion.isEmpty {
                            HStack {
                                VStack(alignment: .leading) {
                                    ZStack {
                                        // Background with stroke
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .background(Color.green.opacity(0.2))
                                            .cornerRadius(20)
                                        
                                        // Text
                                        Text(userQuestion)
                                            .font(.title3)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .padding(5)
                                    }
                                }
                                .padding(.trailing, 5)
                                LottieView(lottieFile: "person")
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.blue.opacity(0.7))
                            }
                        }
                        // AI Response
                        if !viewModel.response.isEmpty {
                            HStack(alignment: .top) {
                                Image("response1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.green, lineWidth: 1)
                                    //                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(20)
                                    
                                    VStack(alignment: .leading) {
                                        let sections = viewModel.response.split(separator: ".", omittingEmptySubsequences: true)
                                        
                                        ForEach(sections, id: \.self) { section in
                                            let responseParts = section.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
                                            let heading = responseParts.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                                            let body = responseParts.count > 1 ? responseParts[1].trimmingCharacters(in: .whitespacesAndNewlines) : ""
                                            
                                            // Only display non-empty headings and bodies
                                            if !heading.isEmpty {
                                                // Heading
                                                Text(heading)
                                                    .font(.title3)
                                                    .bold()
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(5) // Padding inside the rectangle
                                            }
                                            
                                            if !body.isEmpty {
                                                // Body
                                                Text(body)
                                                    .font(.title3)
                                                    .foregroundColor(.black)
                                                    .multilineTextAlignment(.leading)
                                                    .contextMenu {
                                                        Button(action: {
                                                            UIPasteboard.general.string = viewModel.response
                                                            copyMessage = "Copied!"
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                                copyMessage = ""
                                                            }
                                                        }) {
                                                            Text("Copy Response")
                                                            Image(systemName: "doc.on.doc")
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                    .padding(5)
                                }
                                .frame(maxWidth: .infinity)
                                Spacer()
                            }
                        }
                        // MARK: - Loading Indicator
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .font(.system(size: 50))
                        }
                    }
                }
                .onTapGesture {
                    userHasInteracted = true
                }
                
                // MARK: Show Suggestions Lists
                HStack {
                    VStack {
                        Circle()
                            .fill(Color.black.opacity(0.8))
                            .frame(width: 50, height: 50)
                            .overlay(
                                ZStack {
                                    // Lottie Animation
                                    LottieView(lottieFile: "arrowup")
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(5)
                                }
                            )
                            .onTapGesture {
                                isPressed = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isPressed = false
                                    showSheet = true
                                }
                            }
                            .sheet(isPresented: $showSheet) {
                                Text("Suggestions")
                                    .font(.headline)
                                SuggestionView(selectedPrompt: $selectedPrompt, onPromptSelected: {
                                    showSheet = false
                                })
                            }
                    }
                    Spacer()
                }
                .padding(.leading, 5)
                
                // MARK: - Input and Action
                HStack {
                    HStack {
                        // MARK: - Text Input
                        TextField("Ask me anything...", text: $viewModel.userPrompt, axis: .horizontal)
                            .lineLimit(2)
                            .font(.title3)
                            .padding()
                            .disableAutocorrection(true)
                            .onSubmit {
                                userQuestion = viewModel.userPrompt
                                Task { await viewModel.generateResponse() }
                            }
                            .onChange(of: selectedPrompt) { newPrompt in
                                if !newPrompt.isEmpty {
                                    viewModel.userPrompt = newPrompt
                                    selectedPrompt = ""
                                }
                            }
                        
                        // MARK: - Record Button
                        Button(action: {
                            viewModel.toggleRecord()
                        }) {
                            Image(systemName: viewModel.speechToTextViewModel.isRecording ? "mic.fill" : "mic")
                                .resizable()
                                .frame(width: 18, height: 25)
                                .foregroundColor(viewModel.speechToTextViewModel.isRecording ? .red : .gray)
                                .padding(.trailing, 15)
                        }
                    }
                    .background(Color.gray.opacity(0.2), in: Capsule(style: .circular))
                    
                    // MARK: - Send Button
                    Circle()
                        .fill(Color.black)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .bold()
                                .padding(20)
                                .onTapGesture {
                                    userQuestion = viewModel.userPrompt
                                    Task { await viewModel.generateResponse() }
                                    viewModel.hideKeyboard()
                                }
                        )
                }
                .padding(.trailing, 7)
                
            }
            .onTapGesture {
                viewModel.hideKeyboard()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

*/

// MARK: Without Bold

import SwiftUI
import Lottie
import GoogleGenerativeAI

struct ContentView: View {
    @State private var showMenu: Bool = false
    @State private var selectedTab: Int = 0
    @State private var userHasInteracted = false
    @State private var isBlinking = false
    @State private var isPressed = false
    @State private var showSheet = false
    @State private var selectedPrompt: String = ""
    @State private var userQuestion: String = ""
    @State private var copyMessage: String = ""
    @State private var isExpanded: Bool = false

    
    // MARK: - State and ViewModel
    @StateObject private var viewModel = FuncationsViewModels(
        model: GenerativeModel(name: "gemini-pro", apiKey: APIKey.default),
        speechToTextViewModel: SpeechToTextViewModel(speechToTextService: SpeechToTextService())
    )
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                // MARK: - Header
                Text("AI Personal Assistant")
                    .font(.title)
                    .bold()
                
                // MARK: - Response Display
                ZStack {
                    ScrollView {
                        
                        // User Question
                        if !userQuestion.isEmpty {
                            HStack {
                                VStack(alignment: .leading) {
                                    ZStack {
                                        // Background with stroke
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.clear, lineWidth: 1)
                                            .background(Color.green.opacity(0.2))
                                            .cornerRadius(20)
                                        
                                        // Text
                                        Text(userQuestion)
                                            .font(.title3)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .padding(5)
                                    }
                                }
                                .padding(.trailing, 5)
                                LottieView(lottieFile: "person")
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.blue.opacity(0.7))
                            }
                        }
                        // AI Response
                        if !viewModel.response.isEmpty {
                            HStack(alignment: .top) {
                                Image("response1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.green, lineWidth: 1)
                                        .cornerRadius(20)
                                    
                                    VStack(alignment: .leading) {
                                        // Display the full response in a scrollable view
                                        ScrollView {
                                            Text(viewModel.response)
                                                .font(.title3)
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.leading)
                                                .padding(5)
                                                .contextMenu {
                                                    Button(action: {
                                                        UIPasteboard.general.string = viewModel.response
                                                        copyMessage = "Copied!"
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                            copyMessage = ""
                                                        }
                                                    }) {
                                                        Text("Copy Response")
                                                        Image(systemName: "doc.on.doc")
                                                    }
                                                }
                                        }
                                    }
                                    .padding(5)
                                }
                                .frame(maxWidth: .infinity)
                                Spacer()
                            }
                        }                        // MARK: - Loading Indicator
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .font(.system(size: 50))
                        }
                    }
                }
                .onTapGesture {
                    userHasInteracted = true
                }
                
                // MARK: Show Suggestions Lists
                HStack {
                    VStack {
                        Circle()
                            .fill(Color.black.opacity(0.8))
                            .frame(width: 50, height: 50)
                            .overlay(
                                ZStack {
                                    // Lottie Animation
                                    LottieView(lottieFile: "arrowup")
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .padding(5)
                                }
                            )
                            .onTapGesture {
                                isPressed = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isPressed = false
                                    showSheet = true
                                }
                            }
                            .sheet(isPresented: $showSheet) {
                                Text("Suggestions")
                                    .font(.headline)
                                SuggestionView(selectedPrompt: $selectedPrompt, onPromptSelected: {
                                    showSheet = false
                                })
                            }
                    }
                    Spacer()
                }
                .padding(.leading, 5)
                
                // MARK: - Input and Action
                HStack {
                    HStack {
                        // MARK: - Text Input
                        TextField("Ask me anything...", text: $viewModel.userPrompt, axis: .horizontal)
                            .lineLimit(2)
                            .font(.title3)
                            .padding()
                            .disableAutocorrection(true)
                            .onSubmit {
                                userQuestion = viewModel.userPrompt
                                Task { await viewModel.generateResponse() }
                            }
                            .onChange(of: selectedPrompt) { newPrompt in
                                if !newPrompt.isEmpty {
                                    viewModel.userPrompt = newPrompt
                                    selectedPrompt = ""
                                }
                            }
                        
                        // MARK: - Record Button
                        Button(action: {
                            viewModel.toggleRecord()
                        }) {
                            Image(systemName: viewModel.speechToTextViewModel.isRecording ? "mic.fill" : "mic")
                                .resizable()
                                .frame(width: 18, height: 25)
                                .foregroundColor(viewModel.speechToTextViewModel.isRecording ? .red : .gray)
                                .padding(.trailing, 15)
                        }
                    }
                    .background(Color.gray.opacity(0.2), in: Capsule(style: .circular))
                    
                    // MARK: - Send Button
                    Circle()
                        .fill(Color.black)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .bold()
                                .padding(20)
                                .onTapGesture {
                                    userQuestion = viewModel.userPrompt
                                    Task { await viewModel.generateResponse() }
                                    viewModel.hideKeyboard()
                                }
                        )
                }
                .padding(.trailing, 7)
                
            }
            .onTapGesture {
                viewModel.hideKeyboard()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
