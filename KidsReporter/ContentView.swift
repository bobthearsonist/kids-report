import SwiftUI

struct ContentView: View {
    @State private var selectedPhase: AppPhase = .reporting

    var body: some View {
        TabView(selection: $selectedPhase) {
            ReportingPhaseView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("Report")
                }
                .tag(AppPhase.reporting)

            ProductionPhaseView()
                .tabItem {
                    Image(systemName: "video")
                    Text("Create")
                }
                .tag(AppPhase.production)

            DistributionPhaseView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                }
                .tag(AppPhase.distribution)
        }
        .accentColor(.blue)
        .preferredColorScheme(.light)
    }
}

enum AppPhase: CaseIterable {
    case reporting
    case production
    case distribution
}

#Preview {
    ContentView()
}
