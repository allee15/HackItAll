//
//  View+.swift
//  iosApp
//
//  Created by Alexia Aldea on 01.04.2024.
//

import SwiftUI

extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
    
    func borderRadius(_ color: Color, width: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner) -> some View {
        overlay(RoundedCorner(radius: cornerRadius, corners: corners).stroke(color, lineWidth: width))
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func placeHolderMessage<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeHolder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeHolder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

public var SafeAreaInsets: EdgeInsets {
    UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
}

struct GlobalFrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

struct GlobalPositionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geo in
                Color.clear
                    .preference(key: GlobalFrameKey.self, value: geo.frame(in: .global))
            })
    }
}

class TapDetectingView: UIView {
    // Closure to handle the location output
    var onTap: ((CGPoint) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        // Convert to global coordinates if needed
        let globalLocation = self.convert(location, to: nil) // nil converts to window coordinates
        onTap?(globalLocation)
    }
}

struct TapDetectingViewRepresentable: UIViewRepresentable {
    var onTap: ((CGPoint) -> Void)
    
    func makeUIView(context: Context) -> TapDetectingView {
        let view = TapDetectingView()
        view.onTap = onTap
        return view
    }
    
    func updateUIView(_ uiView: TapDetectingView, context: Context) {
    }
}
