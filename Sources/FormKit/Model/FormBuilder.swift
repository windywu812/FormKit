//
//  FormBuilder.swift
//  
//
//  Created by Windy on 29/12/22.
//

import Foundation

@resultBuilder
public struct FormBuilder {
    public static func buildOptional(_ component: [Section]?) -> [Section] {
        component?.compactMap { $0 } ?? []
    }

    public static func buildBlock(_ component: [Section]...) -> [Section] {
        component.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Section?) -> [Section] {
        guard let expression = expression else { return [] }
        return [expression]
    }
}
