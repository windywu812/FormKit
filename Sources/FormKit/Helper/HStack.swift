//
//  HStack.swift
//
//
//  Created by Windy on 27/07/22.
//

import UIKit

final class HStack: UIStackView {
    convenience init(
        spacing: CGFloat = 8,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .top,
        @ViewBuilder views: () -> [UIView]
    ) {
        self.init(arrangedSubviews: views())
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
        axis = .horizontal
    }
}
