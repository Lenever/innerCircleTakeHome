//
//  AppTextFieldRepresentable.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 17/12/2025.
//

import SwiftUI

struct AppTextFieldRepresentable: UIViewRepresentable {
    let title: String
    let placeholder: String
    @Binding var text: String

    func makeUIView(context: Context) -> AppTextField {
        let customField = AppTextField()
        customField.configure(title: title, placeholder: placeholder)
        customField.textField.delegate = context.coordinator
        return customField
    }

    func updateUIView(_ uiView: AppTextField, context: Context) {
        uiView.textField.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AppTextFieldRepresentable
        init(_ parent: AppTextFieldRepresentable) { self.parent = parent }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
