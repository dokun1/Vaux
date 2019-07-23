//
//  File.swift
//  
//
//  Created by Mathieu Barnachon on 28/06/2019.
//

import Foundation

// MARK: - SVGBuilder
/// A function builder that provides transformations for control flow concepts into SVG components.
@_functionBuilder
public struct SVGBuilder {
    
    /// If there are no children in an SVGBuilder closure, then return an empty `MultiNode`
    public static func buildBlock() -> SVG {
        return MultiSVGNode(children: [])
    }
    
    /// Allows you to return one child directly.
    public static func buildBlock(_ content: SVG) -> SVG {
        return content
    }
    
    /// Variadic function that allows you to return all children as a `MultiNode`.
    public static func buildBlock(_ content: SVG...) -> SVG {
        return MultiSVGNode(children: content)
    }
    
    /// Return an empty `MultiNode` or the wrapped value.
    public static func buildIf(_ content: SVG?) -> SVG {
        if let content = content { return content }
        return MultiSVGNode(children: [])
    }
    
    /// If the condition of an `if` statement is `true`, then this method will
    /// be called and the result of evaluating the expressions in the `true` block
    /// will be returned unmodified.
    /// - Note: We do not need to preserve type information
    ///         from both the `true` and `false` blocks, so this function does
    ///         not wrap its passed value.
    /// - Parameters:
    ///   - first: `SVG` object that is going to be built as a result of the `if` statement.
    public static func buildEither(first: SVG) -> SVG {
        return first
    }
    
    /// If the condition of an `if` statement is `false`, then this method will
    /// be called and the result of evaluating the expressions in the `false`
    /// block will be returned unmodified.
    /// - Note: We do not need to preserve type information
    ///         from both the `true` and `false` blocks, so this function does
    ///         not wrap its passed value.
    /// - Parameters:
    ///   - second: `SVG` object that is going to be built as a result of the `if` statement.
    public static func buildEither(second: SVG) -> SVG {
        return second
    }
}
