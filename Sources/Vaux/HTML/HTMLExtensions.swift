//
//  File.swift
//  
//
//  Created by David Okun on 6/6/19.
//

import Foundation

/// Strings are HTML nodes that escape their contents and print on a line.
extension String: HTML {
    public func renderAsHTML(
        into stream: HTMLOutputStream,
        attributes: [Attribute]
        ) {
        for line in split(separator: "\n") {
            stream.writeIndent()
            stream.writeEscaped(line)
            stream.write("\n")
        }
    }
}

/// Optionals are HTML nodes if their underlying values are HTML nodes. If the
/// wrapped value is `nil`, it renders to nothing.
extension Optional: HTML where Wrapped: HTML {
    public func renderAsHTML(
        into stream: HTMLOutputStream,
        attributes: [Attribute]
        ) {
        if let html = self {
            html.renderAsHTML(into: stream, attributes: attributes)
        }
    }
}

extension HTML {
    public func attr(_ key: String, _ value: String? = nil) -> HTML {
        return AttributedNode(attribute: Attribute(key: key, value: value),
                              child: self)
    }
    
    public func `class`(_ value: String) -> HTML {
        return attr("class", value)
    }
}
