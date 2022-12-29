//
//  Section.swift
//  
//
//  Created by Windy on 28/12/22.
//

import UIKit

public struct Section: Hashable {
    @resultBuilder
    public struct RowBuilder {
        public static func buildEither(first component: [FormRow]) -> [FormRow] {
            component
        }

        public static func buildEither(second component: [FormRow]) -> [FormRow] {
            component
        }

        public static func buildOptional(_ component: [FormRow]?) -> [FormRow] {
            component?.compactMap { $0 } ?? []
        }

        public static func buildBlock(_ component: [FormRow]...) -> [FormRow] {
            component.flatMap { $0 }
        }

        public static func buildExpression(_ expression: FormRow?) -> [FormRow] {
            guard let expression = expression else { return [] }
            return [expression]
        }
    }

    var rows: [FormRow]

    public init(@RowBuilder rows: () -> [FormRow]) {
        self.rows = rows()
    }
}

