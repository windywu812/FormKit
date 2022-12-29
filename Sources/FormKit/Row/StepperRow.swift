//
//  StepperRow.swift
//  vidikit-playground
//
//  Created by Windy on 19/05/22.
//

import Combine
import UIKit

public final class StepperRow: FormRow {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var stepperLabel = UILabel()

    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.stepValue = 1
        return stepper
    }()

    public convenience init(
        label labelText: String,
        range: ClosedRange<Int>,
        value: CurrentValueSubject<Int, Never>
    ) {
        self.init()

        label.text = labelText
        stepper.minimumValue = Double(range.lowerBound)
        stepper.maximumValue = Double(range.upperBound)
        stepper.value = Double(value.value)

        stepper.publisher(for: .valueChanged)
            .compactMap { ($0 as? UIStepper)?.value }
            .compactMap { Int($0) }
            .sink(receiveValue: { [weak self] in
                value.send($0)
                self?.stepperLabel.text = "\($0)"
            }).store(in: &subscriptions)

        stepperLabel.text = "\(value.value)"

        contentView.addFill(
            HStack(distribution: .equalCentering, alignment: .center) {
                VStack(spacing: 2) {
                    label
                    stepperLabel
                }
                stepper
            }.margin(.init(vertical: 8, horizontal: 16))
        )
    }
}
