# FormKit

## Description
Simple package for easier to create native form UI

## Code
```swift
FormViewController {
    Section {
        TextRow(label: "TextRow", text: textSubject)
        NumberRow(label: "NumberRow", text: numberRowSubject)
    }
    Section {
        SwitchRow(label: "SwitchRow", isOn: isOnSubject)
    }
    Section {
        SliderRow(label: "Slider", range: 1...100, value: sliderRowSubject)
        StepperRow(label: "StepperRow", range: 1...100, value: stepperRowSubject)
    }
}
```

## Result
<img width="400px" src="https://github.com/windywu812/FormKit/assets/63775386/0fc3522c-96a0-401c-92ac-eece0929416d" />
