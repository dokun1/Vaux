//
//  HTMLBuilder.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

// MARK: - HTMLBuilder
/// A function builder that provides transformations for control flow concepts into HTML components.
@_functionBuilder
public struct HTMLBuilder {

  /// If there are no children in an HTMLBuilder closure, then return an empty `MultiNode`
  public static func buildBlock() -> HTML {
    return MultiNode(children: [])
  }

  /// Allows you to return one child directly.
  public static func buildBlock(_ content: HTML) -> HTML {
    return content
  }

  /// Variadic function that allows you to return all children as a `MultiNode`.
  public static func buildBlock(_ content: HTML...) -> HTML {
    return MultiNode(children: content)
  }

  /// Return an empty `MultiNode` or the wrapped value.
  public static func buildIf(_ content: HTML?) -> HTML {
    if let content = content { return content }
    return MultiNode(children: [])
  }

  /// If the condition of an `if` statement is `true`, then this method will
  /// be called and the result of evaluating the expressions in the `true` block
  /// will be returned unmodified.
  /// - Note: We do not need to preserve type information
  ///         from both the `true` and `false` blocks, so this function does
  ///         not wrap its passed value.
  /// - Parameters:
  ///   - first: `HTML` object that is going to be built as a result of the `if` statement.
  public static func buildEither(first: HTML) -> HTML {
    return first
  }

  /// If the condition of an `if` statement is `false`, then this method will
  /// be called and the result of evaluating the expressions in the `false`
  /// block will be returned unmodified.
  /// - Note: We do not need to preserve type information
  ///         from both the `true` and `false` blocks, so this function does
  ///         not wrap its passed value.
  /// - Parameters:
  ///   - second: `HTML` object that is going to be built as a result of the `if` statement.
  public static func buildEither(second: HTML) -> HTML {
    return second
  }
}
