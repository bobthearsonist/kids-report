import SwiftUI

struct ReportingPhaseView: View {
    var body: some View {
        HStack(spacing: 0) {
            // Left side: Notebook area for sketching
            NotebookView()
                .frame(maxWidth: .infinity)

            // Right side: Camera panel
            CameraPanel()
                .frame(width: 400)
        }
        .navigationTitle("Reporter's Notebook")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ReportingPhaseView()
}
