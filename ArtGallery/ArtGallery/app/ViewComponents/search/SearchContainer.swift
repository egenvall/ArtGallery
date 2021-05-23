import SwiftUI
import Combine
struct SearchContainer: View {
    var text: PassthroughSubject<String, Never>
    var body: some View {
        ZStack {
            VisualEffect(.systemChromeMaterial).edgesIgnoringSafeArea(.top)
            SearchBar(text: text).padding(.horizontal)
        }.frame(height: 100)
    }
}
