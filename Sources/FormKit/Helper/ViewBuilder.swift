//
//  ViewBuilder.swift
//
//
//  Created by Windy on 27/07/22.
//

import UIKit

@resultBuilder
struct ViewBuilder {
    static func buildBlock(_ component: [UIView]...) -> [UIView] {
        component.flatMap { $0 }
    }

    static func buildExpression(_ expression: UIView?) -> [UIView] {
        guard let expression = expression else { return [] }
        return [expression]
    }
}
