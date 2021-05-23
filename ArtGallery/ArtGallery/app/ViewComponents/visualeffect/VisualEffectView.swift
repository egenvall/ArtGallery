import SwiftUI
struct VisualEffect: UIViewRepresentable {
    let style: UIBlurEffect.Style
    init(_ style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
