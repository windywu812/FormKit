//
//  NumberRow.swift
//  vidikit-playground
//
//  Created by Windy on 17/05/22.
//

import Combine
import UIKit

public final class NumberRow: FormRow {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Enter a number here"
        return textField
    }()

    public convenience init(label labelText: String, text: CurrentValueSubject<Int, Never>) {
        self.init()

        label.text = labelText
        textField.text = "\(text.value)"

        textField.publisher(for: \.text)
            .compactMap { Int($0 ?? "0") }
            .sink(receiveValue: text.send(_:))
            .store(in: &subscriptions)

        contentView.addFill(
            VStack(spacing: 2) {
                label
                textField
            }.margin(.init(vertical: 16, horizontal: 12))
        )
    }
}
