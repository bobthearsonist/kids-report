import SwiftUI
import PencilKit

struct NotebookView: View {
    @State private var currentDrawing = PKDrawing()
    @State private var showingTranscription = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Top toolbar
            HStack {
                Text("📝 My Reporter's Notes")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    showingTranscription.toggle()
                }) {
                    HStack {
                        Image(systemName: "text.bubble")
                        Text("Transcription")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            
            // Drawing canvas area
            DrawingCanvasView(drawing: $currentDrawing)
                .background(Color.white)
            
            // Transcription panel (shows/hides)
            if showingTranscription {
                TranscriptionView()
                    .frame(height: 150)
                    .transition(.move(edge: .bottom))
            }
        }
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    NotebookView()
}