import SwiftUI
import Combine
/**
 SwiftUI Wrapper for a SearchBar using a PassthroughSubject
 intead of a typical @Binding <-> @Published
 */
struct SearchBar: UIViewRepresentable {
    var text: PassthroughSubject<String, Never>
    private let searchBar = UISearchBar()
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        searchBar.delegate = context.coordinator
        searchBar.showsCancelButton = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
    }
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text)
    }
    class Coordinator: NSObject, UISearchBarDelegate {
        var text: PassthroughSubject<String, Never>
        
        init(_ text: PassthroughSubject<String, Never>) {
            self.text = text
        }
        // MARK: UISearchBarDelegate
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text.send(searchText)
        }
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            resign(searchBar)
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            resign(searchBar)
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text.send("")
            resign(searchBar)
            
        }
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            toggleCancelButton(searchBar, enabled: true)
            return true
        }
        private func resign(_ searchBar: UISearchBar) {
            toggleCancelButton(searchBar, enabled: false)
            searchBar.resignFirstResponder()
        }
        private func toggleCancelButton(_ searchBar: UISearchBar, enabled: Bool) {
            searchBar.setShowsCancelButton(enabled, animated: true)
        }
    }
}
