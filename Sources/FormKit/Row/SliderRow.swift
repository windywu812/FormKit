//
//  SliderRow.swift
//  vidikit-storybook-ios
//
//  Created by Windy on 13/06/22.
//

import Combine
import UIKit

public final class SliderRow: FormRow {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var slider = UISlider()

    public convenience init(
        label labelText: String,
        range: ClosedRange<Float>,
        value: CurrentValueSubject<Float, Never>
    ) {
        self.init()

        label.text = labelText
        slider.value = value.value
        slider.maximumValue = range.upperBound
        slider.minimumValue = range.lowerBound
        slider.publisher(for: .valueChanged)
            .compactMap { ($0 as? UISlider)?.value }
            .sink(receiveValue: value.send(_:))
            .store(in: &subscriptions)

        contentView.addFill(
            VStack(spacing: 2) {
                label
                slider
            }.margin(.init(vertical: 8, horizontal: 16))
        )
    }
}
