import SwiftUI
import AVFoundation

struct CameraPanel: View {
    @State private var isExpanded = true
    @State private var isRecording = false
    @State private var recordingTime: TimeInterval = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Camera panel header
            HStack {
                Button(action: {
                    withAnimation(.spring()) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: isExpanded ? "chevron.right" : "chevron.left")
                        Text(isExpanded ? "Hide Camera" : "Show Camera")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }
                
                Spacer()
                
                if isExpanded {
                    Text("🎥 Interview Camera")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            
            // Camera content (expandable)
            if isExpanded {
                VStack {
                    // Camera preview area
                    CameraPreviewView()
                        .frame(height: 300)
                        .cornerRadius(12)
                        .padding()
                    
                    // Recording controls
                    HStack(spacing: 20) {
                        // Record button
                        Button(action: {
                            toggleRecording()
                        }) {
                            Circle()
                                .fill(isRecording ? Color.red : Color.gray)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: isRecording ? 20 : 0, height: isRecording ? 20 : 0)
                                        .cornerRadius(isRecording ? 4 : 30)
                                )
                        }
                        
                        // Recording time display
                        if isRecording {
                            Text(formatTime(recordingTime))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6))
    }
    
    private func toggleRecording() {
        isRecording.toggle()
        // TODO: Implement actual recording logic
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    CameraPanel()
}