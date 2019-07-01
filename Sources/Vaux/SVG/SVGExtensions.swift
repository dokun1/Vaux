//
//  File.swift
//  
//
//  Created by Mathieu Barnachon on 01/07/2019.
//

import Foundation

/// Strings are HTML nodes that escape their contents and print on a line.
extension String: SVG {
}

/// Numeric literals should be interpreted as strings when being written to HTML
extension Int: SVG {
}

/// Numeric literals should be interpreted as strings when being written to HTML
extension Double: SVG {
}

/// Numeric literals should be interpreted as strings when being written to HTML
extension Float: SVG {
}

/// Optionals are HTML nodes if their underlying values are HTML nodes. If the
/// wrapped value is `nil`, it renders to nothing.
extension Optional: SVG where Wrapped: SVG {
    public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        if let svg = self {
            svg.renderAsHTML(into: stream, attributes: attributes)
        }
    }
    
    public func getTag() -> String? {
        if let svg = self {
            return svg.getTag()
        } else {
            return nil
        }
    }
}
