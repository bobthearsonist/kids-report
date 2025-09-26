import AVFoundation
import SwiftUI

// CameraManager handles all the AVFoundation camera setup
// This separates the complex camera logic from our SwiftUI views
class CameraManager: NSObject, ObservableObject {
    @Published var isRecording = false
    @Published var recordingDuration: TimeInterval = 0
    @Published var isAuthorized = false
    @Published var authorizationStatus = AVAuthorizationStatus.notDetermined
    
    // AVCaptureSession coordinates data flow between inputs and outputs
    private var captureSession = AVCaptureSession()
    private var videoOutput = AVCaptureMovieFileOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    // Timer for tracking recording duration
    private var recordingTimer: Timer?
    
    override init() {
        super.init()
        checkCameraPermission()
    }
    
    // Request camera permission first before setting up camera
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isAuthorized = true
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.isAuthorized = granted
                    if granted {
                        self.setupCamera()
                    }
                }
            }
        case .denied, .restricted:
            isAuthorized = false
        @unknown default:
            isAuthorized = false
        }
    }
    
    // Configure the camera session with video input and output
    private func setupCamera() {
        captureSession.sessionPreset = .hd1920x1080
        
        // Get any available video device
        guard let videoDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            print("No video device available")
            return
        }
        
        // Add video input to session
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        // Configure video output for recording
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        // Start the capture session on background queue
        DispatchQueue.global(qos: .userInitiated).async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }    // Create the preview layer that shows camera feed
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer {
        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = .resizeAspectFill
        }
        return previewLayer!
    }
    
    // Check if camera hardware is actually available
    var isCameraAvailable: Bool {
        return AVCaptureDevice.default(for: .video) != nil
    }

    // Start/stop video recording with safety checks
    func toggleRecording() {
        // Only allow recording if authorized and session is running
        guard isAuthorized && captureSession.isRunning else {
            print("Cannot record: camera not authorized or session not running")
            return
        }
        
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    private func startRecording() {
        // Double-check we can actually record
        guard captureSession.outputs.contains(videoOutput) else {
            print("Video output not available for recording")
            return
        }
        
        // Create temporary URL for video file
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let videoPath = "\(documentsPath)/recording_\(Date().timeIntervalSince1970).mov"
        let videoURL = URL(fileURLWithPath: videoPath)

        // Start recording to file
        videoOutput.startRecording(to: videoURL, recordingDelegate: self)

        // Start timer to track duration
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.recordingDuration += 0.1
        }

        isRecording = true
    }

    private func stopRecording() {
        videoOutput.stopRecording()
        recordingTimer?.invalidate()
        recordingTimer = nil
        recordingDuration = 0
        isRecording = false
    }
}

// Handle recording completion callbacks
extension CameraManager: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print("Recording error: \(error)")
        } else {
            print("Video saved to: \(outputFileURL)")
            // Here we could save to photo library or process the video
        }
    }
}
