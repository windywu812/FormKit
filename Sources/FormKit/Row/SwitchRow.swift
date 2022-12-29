//
//  FormSwitch.swift
//  vidikit-playground
//
//  Created by Windy on 09/05/22.
//

import Combine
import UIKit

public final class SwitchRow: FormRow {
    private lazy var label = UILabel()
    private lazy var formSwitch = UISwitch()

    public convenience init(label labelText: String, isOn: CurrentValueSubject<Bool, Never>) {
        self.init()

        label.text = labelText

        formSwitch.isOn = isOn.value
        formSwitch.publisher(for: .valueChanged)
            .compactMap { ($0 as? UISwitch)?.isOn }
            .sink(receiveValue: {
                print($0)
                isOn.send($0)
            })
            .store(in: &subscriptions)

        contentView.addFill(
            HStack(
                spacing: 2,
                distribution: .equalCentering,
                alignment: .center
            ) {
                label
                formSwitch
            }.margin(.init(vertical: 8, horizontal: 16))
        )
    }
}
