import SwiftUI

struct DistributionPhaseView: View {
    var body: some View {
        VStack {
            Text("📤 Distribution Phase")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Safe sharing options will go here")
                .font(.title2)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    DistributionPhaseView()
}