import SwiftUI
import AVFoundation

struct CameraPreviewView: View {
    @ObservedObject var cameraManager: CameraManager
    
    var body: some View {
        Group {
            if cameraManager.isAuthorized && cameraManager.isCameraAvailable {
                CameraPreview(cameraManager: cameraManager)
            } else if !cameraManager.isAuthorized {
                // Camera permission not granted
                Rectangle()
                    .fill(Color.black)
                    .overlay(
                        VStack {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("Camera Access Required")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("Please grant camera permission in Settings")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    )
            } else {
                // No camera hardware available
                Rectangle()
                    .fill(Color.black)
                    .overlay(
                        VStack {
                            Image(systemName: "video.slash")
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text("No Camera Available")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("Camera hardware not detected")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                    )
            }
        }
        .cornerRadius(8)
    }
}

// UIViewRepresentable wraps UIKit's AVCaptureVideoPreviewLayer for SwiftUI
struct CameraPreview: UIViewRepresentable {
    let cameraManager: CameraManager

    // Create the UIView that will show our camera feed
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .black

        let previewLayer = cameraManager.getPreviewLayer()
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)

        return view
    }

    // Update the view when SwiftUI state changes
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the preview layer frame when view size changes
        if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            DispatchQueue.main.async {
                previewLayer.frame = uiView.bounds
            }
        }
    }
}

#Preview {
    CameraPreviewView(cameraManager: CameraManager())
}
