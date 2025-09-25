import SwiftUI

struct TranscriptionView: View {
    @State private var transcribedText = "Interview transcription will appear here..."
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "waveform")
                    .foregroundColor(.blue)
                Text("Live Transcription")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Clear") {
                    transcribedText = ""
                }
                .font(.caption)
                .foregroundColor(.red)
            }
            
            ScrollView {
                Text(transcribedText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
    }
}

#Preview {
    TranscriptionView()
}