//
//  MultipleLineTextRow.swift
//  vidikit-playground
//
//  Created by Windy on 11/05/22.
//

import Combine
import UIKit

public final class MultipleLineTextRow: FormRow {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()

    public convenience init(
        label labelText: String,
        text: CurrentValueSubject<String, Never>
    ) {
        self.init()

        label.text = labelText
        textView.text = text.value

        NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification)
            .compactMap { ($0.object as? UITextView)?.text }
            .sink(receiveValue: { [weak self] in
                text.send($0)
                self?.invalidateLayout()
            }).store(in: &subscriptions)

        contentView.addFill(
            VStack(spacing: 2) {
                label
                textView
            }.margin(.init(vertical: 8, horizontal: 16))
        )
    }
}
