import SwiftUI

struct TranscriptionView: View {
    @StateObject private var speechManager = SpeechManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: speechManager.isTranscribing ? "waveform" : "mic.slash")
                    .foregroundColor(speechManager.isTranscribing ? .green : .blue)
                    .animation(.easeInOut, value: speechManager.isTranscribing)
                
                Text("Live Transcription")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if speechManager.isAuthorized {
                    // Start/Stop transcription button
                    Button(speechManager.isTranscribing ? "Stop" : "Start") {
                        if speechManager.isTranscribing {
                            speechManager.stopTranscription()
                        } else {
                            do {
                                try speechManager.startTranscription()
                            } catch {
                                print("Failed to start transcription: \(error)")
                            }
                        }
                    }
                    .font(.caption)
                    .foregroundColor(speechManager.isTranscribing ? .red : .green)
                    .fontWeight(.semibold)
                    
                    Button("Clear") {
                        speechManager.clearTranscription()
                    }
                    .font(.caption)
                    .foregroundColor(.orange)
                } else {
                    Text("Speech Permission Required")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            ScrollView {
                Text(speechManager.transcriptionText.isEmpty ? 
                     (speechManager.isAuthorized ? "Tap Start to begin transcription..." : "Please grant microphone and speech recognition permissions in Settings") : 
                     speechManager.transcriptionText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .foregroundColor(speechManager.transcriptionText.isEmpty ? .gray : .black)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
    }
}

#Preview {
    TranscriptionView()
}