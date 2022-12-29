//
//  VStack.swift
//
//
//  Created by Windy on 27/07/22.
//

import UIKit

final class VStack: UIStackView {
    convenience init(
        spacing: CGFloat = 8,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        @ViewBuilder views: () -> [UIView]
    ) {
        self.init(arrangedSubviews: views())
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
        axis = .vertical
    }
}

extension UIStackView {
    @discardableResult
    func margin(_ margin: UIEdgeInsets) -> Self {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = margin
        return self
    }
}
