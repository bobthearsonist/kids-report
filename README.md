# Kids Reporter iOS App

An iPad-native app designed for children to go on "reporting" missions with three distinct phases: reporting, production, and distribution.

## App Overview

The Kids Reporter app is structured around three main phases:

1. **Reporting Phase**: Interactive notebook sketching with collapsible camera recording and automatic interview transcription
2. **Production Phase**: Drag-and-drop video editor with PowerPoint-like frame builder
3. **Distribution Phase**: Safe sharing limited to iPhoto shared albums and Messages (no external platforms)

## Features

- **Privacy-First Design**: Child safety is paramount with no external sharing platforms
- **iPad-Optimized UI**: Large touch targets and intuitive gestures designed for young users
- **Accessibility Features**: Clear visual hierarchy and child-appropriate interface design
- **Split-Screen Interface**: Notebook sketching alongside camera recording in reporting phase

## Technical Stack

- **Platform**: iOS 17.0+ (iPad only)
- **Language**: Swift with SwiftUI
- **Architecture**: MVVM pattern
- **Key Frameworks**:
  - SwiftUI for modern declarative UI
  - PencilKit for drawing and sketching
  - AVFoundation for camera and video recording
  - Speech recognition for automatic transcription

## Development Toolchain

This project uses a modern, CLI-friendly development workflow:

### Project Management

- **XcodeGen**: YAML-based Xcode project generation instead of traditional `.xcodeproj` files
- **Configuration**: All project settings defined in `project.yml` for version control friendliness
- **Benefits**: Eliminates merge conflicts in binary project files, enables reproducible builds

### Build System

```bash
# Generate Xcode project from YAML configuration
xcodegen generate

# Build for iPad simulator
xcodebuild -project KidsReporter.xcodeproj -scheme KidsReporter \
  -destination 'platform=iOS Simulator,name=iPad Pro 13-inch (M4)' build

# Launch in iPad simulator
xcrun simctl list devices | grep iPad
xcrun simctl boot "iPad Pro 13-inch (M4)"
xcrun simctl install booted ./path/to/app
xcrun simctl launch booted com.example.KidsReporter
```

### File Structure

```
KidsReporter/
├── KidsReporterApp.swift          # Main app entry point
├── ContentView.swift              # Tab-based navigation
├── Views/                         # Feature-specific views
│   ├── ReportingPhaseView.swift   # Split-screen reporting interface
│   ├── NotebookView.swift         # Drawing canvas with transcription
│   ├── CameraPanel.swift          # Collapsible camera controls
│   ├── ProductionPhaseView.swift  # Video editing interface
│   └── DistributionPhaseView.swift # Safe sharing interface
└── Assets.xcassets/               # App icons and assets
```

## Getting Started

1. Install dependencies:

   ```bash
   brew install xcodegen
   ```

2. Generate Xcode project:

   ```bash
   xcodegen generate
   ```

3. Open in Xcode or build from command line:
   ```bash
   open KidsReporter.xcodeproj
   ```

## Current Status

✅ Basic project structure and three-phase navigation
✅ Reporting phase split-screen UI with collapsible camera panel
✅ XcodeGen-based project management
✅ Asset catalog setup with proper iPad configuration
🔄 PencilKit drawing implementation (placeholder ready)
🔄 AVFoundation camera recording (UI complete, integration pending)
⭕ Speech recognition for transcription
⭕ Production phase drag-and-drop video editor
⭕ Distribution phase safe sharing features

## Educational Goals

This project serves as a learning exercise for Swift/SwiftUI development, demonstrating:

- Modern iOS app architecture patterns
- Child-safe UI design principles
- CLI-based development workflows
- Integration of multiple iOS frameworks
