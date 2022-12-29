//
//  FormTextField.swift
//  vidikit-playground
//
//  Created by Windy on 09/05/22.
//

import Combine
import UIKit

public final class TextRow: FormRow {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a text here"
        return textField
    }()

    public convenience init(label labelText: String, text: CurrentValueSubject<String, Never>) {
        self.init()

        label.text = labelText

        textField.text = text.value
        textField.publisher(for: \.text)
            .replaceNil(with: "")
            .sink(receiveValue: text.send(_:))
            .store(in: &subscriptions)

        contentView.addFill(
            VStack(spacing: 2) {
                label
                textField
            }.margin(.init(vertical: 8, horizontal: 16))
        )
    }
}
