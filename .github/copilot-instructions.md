<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Kids Reporter App - iOS Native Development Guidelines

This is an iOS native app for iPad designed for kids to go on "reporting" missions with three distinct phases:

### Audio Chat Response Guidelines:

- Keep responses conversational and concise for audio consumption
- Use short sentences that flow naturally when read aloud
- Avoid long bullet point lists - prefer narrative explanations
- Skip excessive markdown formatting that doesn't translate to speech
- Focus on one main concept per response
- Use natural transitions between ideas
- Explain code changes in plain language before showing code
- Ask clarifying questions to keep dialogue flowing
- Keep technical jargon to minimum unless specifically needed
- Run console commands separately since they auto-approve - don't chain multiple commands with &&

### App Structure:

1. **Reporting Phase**: Notebook sketching, camera recording with collapse/expand functionality, automatic interview transcription
2. **Production Phase**: Drag-and-drop video editor, PowerPoint-like frame builder, video selection interface
3. **Distribution Phase**: Safe sharing limited to iPhoto shared albums and Messages (no YouTube/external platforms)

### Development Guidelines:

- Target: iPad (iOS 15.0+)
- Language: Swift with SwiftUI for modern UI
- Architecture: MVVM pattern
- Privacy-first design for child safety
- Accessibility features for young users
- Large touch targets and intuitive gestures

### Key Features to Implement:

- AVFoundation for camera and video recording
- Speech recognition for transcription
- Core Graphics for sketching
- Drag-and-drop interfaces using SwiftUI
- Photo library integration
- Message composition integration
- Child-appropriate UI with large buttons and clear visual hierarchy

- [x] Verify that the copilot-instructions.md file in the .github directory is created.
- [x] Clarify Project Requirements - iOS iPad app for kids reporting missions
- [x] Scaffold the Project - Created Xcode project structure with SwiftUI
- [x] Customize the Project - Built basic view hierarchy with reporting/production/distribution phases
- [ ] Install Required Extensions
- [ ] Compile the Project
- [ ] Create and Run Task
- [ ] Launch the Project
- [ ] Ensure Documentation is Complete
