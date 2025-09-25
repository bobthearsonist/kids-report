import SwiftUI

struct ProductionPhaseView: View {
    var body: some View {
        VStack {
            Text("🎬 Production Phase")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Drag-and-drop video editor will go here")
                .font(.title2)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    ProductionPhaseView()
}