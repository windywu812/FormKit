//
//  FormRow.swift
//  
//
//  Created by Windy on 29/12/22.
//

import Combine
import UIKit

public class FormRow: UITableViewCell {
    var invalidateLayout: (() -> Void) = {}
    var subscriptions = Set<AnyCancellable>()

    public init() {
        super.init(style: .default, reuseIdentifier: String(describing: Self.self))
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
