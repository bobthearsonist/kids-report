import Speech
import AVFoundation
import SwiftUI

// SpeechManager handles speech recognition for automatic transcription
// This uses Apple's Speech framework to convert audio to text
class SpeechManager: NSObject, ObservableObject {
    @Published var isTranscribing = false
    @Published var transcriptionText = ""
    @Published var isAuthorized = false
    
    // Speech recognition components
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override init() {
        super.init()
        requestSpeechPermission()
    }
    
    // Request permission for speech recognition
    private func requestSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    self.isAuthorized = true
                case .denied, .restricted, .notDetermined:
                    self.isAuthorized = false
                @unknown default:
                    self.isAuthorized = false
                }
            }
        }
    }
    
    // Start speech recognition
    func startTranscription() throws {
        // Cancel any existing task
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure audio session for recording
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // Create recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            throw SpeechError.recognitionRequestFailed
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        // Get audio input node
        let inputNode = audioEngine.inputNode
        
        // Create recognition task
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                DispatchQueue.main.async {
                    self.transcriptionText = result.bestTranscription.formattedString
                    isFinal = result.isFinal
                }
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                DispatchQueue.main.async {
                    self.isTranscribing = false
                }
            }
        }
        
        // Configure audio input
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }
        
        // Start audio engine
        audioEngine.prepare()
        try audioEngine.start()
        
        isTranscribing = true
        transcriptionText = "Listening..."
    }
    
    // Stop speech recognition
    func stopTranscription() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        isTranscribing = false
    }
    
    // Clear transcription text
    func clearTranscription() {
        transcriptionText = ""
    }
}

// Custom error types for speech recognition
enum SpeechError: Error {
    case recognitionRequestFailed
    case audioEngineError
    case permissionDenied
}