//
//  File.swift
//  
//
//  Created by Mathieu Barnachon on 28/06/2019.
//

import Foundation

/// Represents an SVG tag like `<circle>{{content}}</circle>`, with a tag and an
/// optional SVG child.
struct SVGNode: SVG {
    var tag: String
    var child: SVG?
    var inline = false
    
    func getTag() -> String? {
        return self.tag
    }
    
    func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        /// Open the tag
        stream.writeIndent()
        stream.write("<")
        stream.write(tag)
        
        /// Append the tag with all attributes.
        for attr in attributes {
            stream.write(" ")
            stream.write(attr.key)
            
            /// If an attribute does not have a value, do not add the equal sign.
            if let value = attr.value {
                stream.write("=")
                stream.writeDoubleQuoted(value)
            }
        }
        
        /// If the element has no children, close it on the same line.
        guard let child = child else {
            stream.write("/>")
            stream.writeNewline()
            return
        }
        
        stream.write(">")
        
        /// Check to see if the tag being streamed should write its child and close it on the same line
        if inline {
            if let childString = child as? String {
                stream.write(childString)
            }
            /// Otherwise, add the child indented on a new line
        } else {
            stream.writeNewline()
            stream.withIndent {
                child.renderAsHTML(into: stream, attributes: [])
            }
            stream.writeIndent()
        }
        /// Add a new line and write the closing tag.
        stream.write("</")
        stream.write(tag)
        stream.write(">")
        stream.writeNewline()
    }
}

/// Wraps an SVG object with a given attribute. these attributes are collected
/// while walking the node hierarchy and finally printed when printing an
/// `SVGNode`.
struct AttributedSVGNode: SVG {
    let attribute: Attribute
    let child: SVG
    
    func getTag() -> String? {
        return child.getTag()
    }
    
    func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        var fullAttrs = attributes
        fullAttrs.append(attribute)
        child.renderAsHTML(into: stream, attributes: fullAttrs)
    }
}

/// MultiNode is an implementation detail for representing multiple sequenced
/// SVG nodes
struct MultiSVGNode: SVG {
    
    func getTag() -> String? {
        return nil
    }
    
    let children: [SVG]
    func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        for child in children {
            child.renderAsHTML(into: stream, attributes: attributes)
        }
    }
}

struct HTMLSVGNode: HTML {
    let node: SVGNode
    
    func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        node.renderAsHTML(into: stream, attributes: attributes)
    }
    
    func getTag() -> String? {
        return node.getTag()
    }
    
    
}
