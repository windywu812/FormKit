//
//  File.swift
//
//
//  Created by Windy on 27/07/22.
//

import UIKit

extension UIEdgeInsets {
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
}
