//
//  File.swift
//  
//
//  Created by David Okun on 6/6/19.
//

import Foundation

// MARK: - HTMLBuilder
/// A function builder that provides transformations for control flow concepts
/// into HTML components.
@_functionBuilder
public struct HTMLBuilder {
    /// If there are no children in an HTMLBuilder closure, then return an empty
    /// MultiNode.
    public static func buildBlock() -> HTML {
        return MultiNode(children: [])
    }
    
    /// If there is one child, return it directly.
    public static func buildBlock(_ content: HTML) -> HTML {
        return content
    }
    
    /// If there are multiple children, return them all as a MultiNode.
    public static func buildBlock(_ content: HTML...) -> HTML {
        return MultiNode(children: content)
    }
    
    /// If the provided child is `nil`, build an empty MultiNode. Otherwise,
    /// return the wrapped value.
    public static func buildIf(_ content: HTML?) -> HTML {
        if let content = content { return content }
        return MultiNode(children: [])
    }
    
    /// If the condition of an `if` statement is `true`, then this method will
    /// be called and the result of evaluating the expressions in the `true` block
    /// will be returned unmodified.
    /// - note: We do not need to preserve type information
    ///         from both the `true` and `false` blocks, so this function does
    ///         not wrap its passed value.
    public static func buildEither(first: HTML) -> HTML {
        return first
    }
    
    /// If the condition of an `if` statement is `false`, then this method will
    /// be called and the result of evaluating the expressions in the `false`
    /// block will be returned unmodified.
    /// - note: We do not need to preserve type information
    ///         from both the `true` and `false` blocks, so this function does
    ///         not wrap its passed value.
    public static func buildEither(second: HTML) -> HTML {
        return second
    }
}

// MARK: - Some HTML shorthand functions
public func div(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "div", child: child())
}

public func head(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "head", child: child())
}

public func body(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "body", child: child())
}

public func html(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "html", child: child())
}

public func title(_ text: String) -> HTML {
    return HTMLNode(tag: "title", child: text)
}

public func br() -> HTML {
    return HTMLNode(tag: "br", child: nil)
}

/// Iterates over a collection of data and applies a transformation to each
/// piece of data that creates an HTML node.
public func forEach<Coll: Collection>(
    _ data: Coll,
    @HTMLBuilder content: @escaping (Coll.Element) -> HTML
    ) -> HTML {
    return MultiNode(children: data.map(content))
}
