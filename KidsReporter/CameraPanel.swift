import SwiftUI
import AVFoundation

struct CameraPanel: View {
    @StateObject private var cameraManager = CameraManager()
    @State private var isExpanded = true

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
                    // Camera preview area - now using real camera manager
                    CameraPreviewView(cameraManager: cameraManager)
                        .frame(height: 300)
                        .cornerRadius(12)
                        .padding()

                    // Recording controls
                    HStack(spacing: 20) {
                        // Record button - now connected to camera manager
                        Button(action: {
                            cameraManager.toggleRecording()
                        }) {
                            Circle()
                                .fill(cameraManager.isRecording ? Color.red : Color.gray)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(
                                            width: cameraManager.isRecording ? 20 : 0,
                                            height: cameraManager.isRecording ? 20 : 0
                                        )
                                        .cornerRadius(cameraManager.isRecording ? 4 : 30)
                                )
                        }

                        // Recording time display - now using real duration from camera manager
                        if cameraManager.isRecording {
                            Text(formatTime(cameraManager.recordingDuration))
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

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    CameraPanel()
}
