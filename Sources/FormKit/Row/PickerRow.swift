//
//  FormPicker.swift
//  vidikit-playground
//
//  Created by Windy on 09/05/22.
//

import Combine
import UIKit

public final class PickerRow: FormRow {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var textField = TextField()
    private var pickerView: PickerView!

    public convenience init(
        label labelText: String,
        selections: [String],
        index subject: CurrentValueSubject<Int, Never>
    ) {
        self.init()
        
        pickerView = PickerView(
            selections: selections,
            onSelect: { [weak self] in
                subject.send($0)
                self?.textField.text = selections[$0]
            }
        )
        label.text = labelText
        textField.text = selections[subject.value]
        textField.inputView = pickerView

        contentView.addFill(
            VStack(spacing: 2) {
                label
                textField
            }.margin(.init(vertical: 8, horizontal: 16))
        )
    }
    
}

private final class TextField: UITextField, UITextFieldDelegate {
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(handleDonePickerAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        return toolBar
    }()

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        delegate = self
        inputAccessoryView = toolBar
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func handleDonePickerAction() {
        resignFirstResponder()
    }

    func textField(
        _: UITextField,
        shouldChangeCharactersIn _: NSRange,
        replacementString _: String
    ) -> Bool {
        return false
    }
}

private final class PickerView: UIPickerView {
    private let selections: [String]
    private let onSelect: (Int) -> Void

    init(selections: [String], onSelect: @escaping ((Int) -> Void)) {
        self.selections = selections
        self.onSelect = onSelect
        super.init(frame: .zero)
        delegate = self
        dataSource = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        onSelect(row)
    }

    func pickerView(
        _: UIPickerView,
        titleForRow row: Int,
        forComponent _: Int
    ) -> String? {
        selections[row]
    }

    func numberOfComponents(in _: UIPickerView) -> Int {
        1
    }

    func pickerView(
        _: UIPickerView,
        numberOfRowsInComponent _: Int
    ) -> Int {
        selections.count
    }
}

extension PickerView: UITextFieldDelegate {
    func textField(
        _: UITextField,
        shouldChangeCharactersIn _: NSRange,
        replacementString _: String
    ) -> Bool {
        return false
    }
}
