///*
//import Foundation
//import Speech
//import AVFoundation
//
//class SpeechRecognizer: ObservableObject {
//    private var speechRecognizer = SFSpeechRecognizer()
//    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    private var recognitionTask: SFSpeechRecognitionTask?
//    private let audioEngine = AVAudioEngine()
//    
//    @Published var transcribedText = ""
//    
//    init() {
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//            DispatchQueue.main.async {
//                if authStatus != .authorized {
//                    self.transcribedText = "Speech recognition permission denied."
//                }
//            }
//        }
//    }
//    
//    func startRecording() {
//        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
//            transcribedText = "Speech recognition is not authorized."
//            return
//        }
//        
//        do {
//            // Setup audio session
//            let audioSession = AVAudioSession.sharedInstance()
//            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
//            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//            
//            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//            guard let recognitionRequest = recognitionRequest else {
//                transcribedText = "Unable to create a recognition request."
//                return
//            }
//            
//            let inputNode = audioEngine.inputNode
//            recognitionRequest.shouldReportPartialResults = true
//            
//            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
//                if let result = result {
//                    DispatchQueue.main.async {
//                        self.transcribedText = result.bestTranscription.formattedString
//                    }
//                }
//                if error != nil || result?.isFinal == true {
//                    self.stopRecording()
//                }
//            }
//            
//            let recordingFormat = inputNode.outputFormat(forBus: 0)
//            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
//                recognitionRequest.append(buffer)
//            }
//            
//            audioEngine.prepare()
//            try audioEngine.start()
//        } catch {
//            transcribedText = "Audio Engine couldn't start: \(error.localizedDescription)"
//        }
//    }
//    
//    func stopRecording() {
//        audioEngine.stop()
//        recognitionRequest?.endAudio()
//        recognitionTask?.cancel()
//        recognitionRequest = nil
//        recognitionTask = nil
//        
//        let inputNode = audioEngine.inputNode
//        inputNode.removeTap(onBus: 0)
//    }
//}
//*/
//
//
//import Foundation
//import Speech
//import AVFoundation
//
//class SpeechRecognizer: ObservableObject {
//    private var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
//    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    private var recognitionTask: SFSpeechRecognitionTask?
//    private let audioEngine = AVAudioEngine()
//    
//    @Published var transcribedText: String = ""
//    
//    init() {
//        requestAuthorization()
//    }
//    
//    private func requestAuthorization() {
//        SFSpeechRecognizer.requestAuthorization { authStatus in
//            switch authStatus {
//            case .authorized:
//                print("Speech recognition authorized")
//            case .denied:
//                print("User  denied access to speech recognition")
//            case .restricted:
//                print("Speech recognition restricted on this device")
//            case .notDetermined:
//                print("Speech recognition not yet authorized")
//            @unknown default:
//                break
//            }
//        }
//    }
//    
//    func startRecording() {
//        // Reset any previous recognition task
//        recognitionTask?.cancel()
//        recognitionTask = nil
//        
//        // Create a recognition request
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//        
//        guard let recognitionRequest = recognitionRequest else { return }
//        
//        // Configure the audio session
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
//            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        } catch {
//            print("Audio session properties weren't set because of an error.")
//        }
//        
//        // Create an input node
//        let inputNode = audioEngine.inputNode
//        recognitionRequest.shouldReportPartialResults = true
//        
//        // Start the recognition task
//        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
//            if let result = result {
//                self.transcribedText = result.bestTranscription.formattedString
//            }
//            
//            if let error = error {
//                print("Recognition error: \(error.localizedDescription)")
//                self.stopRecording()
//            }
//        }
//        
//        // Install a tap on the audio engine's input node
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputNode.outputFormat(forBus: 0)) { (buffer, when) in
//            recognitionRequest.append(buffer)
//        }
//    audioEngine.prepare()
//        do {
//            try audioEngine.start()
//        } catch {
//            print("Audio engine couldn't start because of an error.")
//        }
//    }
//    
//    func stopRecording() {
//        audioEngine.stop()
//        recognitionRequest?.endAudio()
//        recognitionTask?.cancel()
//        recognitionTask = nil
//    }
//}
