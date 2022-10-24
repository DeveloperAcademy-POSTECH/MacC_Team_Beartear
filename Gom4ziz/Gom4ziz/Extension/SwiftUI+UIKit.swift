//
//  UIKitPreviewExtension.swift
//  dorm
//
//  Created by JongHo Park on 2022/07/19.
//

#if DEBUG
import UIKit
import SwiftUI

extension UIViewController {
    public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
        public let viewController: ViewController

        public init(_ builder: @autoclosure () -> ViewController) {
            viewController = builder()
        }

        // MARK: - UIViewControllerRepresentable
        public func makeUIViewController(context: Context) -> ViewController {
            viewController
        }

        public func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {

        }
    }

    func toPreview() -> some View {
        UIViewControllerPreview(self)
    }
}

extension UIView {
    public struct UIViewPreview<View: UIView>: UIViewRepresentable {
            public let view: View
            public init(_ builder: @autoclosure () -> View) {
                view = builder()
            }
            // MARK: - UIViewRepresentable
            public func makeUIView(context: Context) -> UIView {
                return view
            }
            public func updateUIView(_ view: UIView, context: Context) {
            }
        }

    func toPreview() -> some View {
        UIViewPreview(self)
    }
}
#endif
