//
//  File.swift
//  
//
//  Created by David Okun on 6/6/19.
//

import Foundation

/// Represents an HTML tag like `<div>{{content}}</div>`, with a tag and an
/// optional HTML child.
struct HTMLNode: HTML {
    var tag: String
    var child: HTML?
    
    func renderAsHTML(
        into stream: HTMLOutputStream,
        attributes: [Attribute]
        ) {
        
        // Write the opening of the tag, e.g. `<div`
        stream.writeIndent()
        stream.write("<")
        stream.write(tag)
        
        // Write each attribute, e.g. `class="my-class"`.
        for attr in attributes {
            stream.write(" ")
            stream.write(attr.key)
            
            // Some attributes do not have values, and instead use the presence of the
            // for its effects, such as `<input disabled>`.
            if let value = attr.value {
                stream.write("=")
                stream.writeDoubleQuoted(value)
            }
        }
        
        // If this node has no children, end the tag without introducing a second
        // closing tag, e.g. `<br />`.
        guard let child = child else {
            stream.write("/>\n")
            return
        }
        
        // Otherwise, add a newline and render the child indented.
        stream.write(">\n")
        stream.withIndent {
            // Explicitly do not pass any attributes to children.
            child.renderAsHTML(into: stream, attributes: [])
        }
        
        // Write the closing tag on its own line.
        stream.writeIndent()
        stream.write("</")
        stream.write(tag)
        stream.write(">\n")
    }
}

// MARK: - Concatenative HTML Attributes
public struct Attribute {
    let key: String
    let value: String?
}

/// Wraps an HTML object with a given attribute. these attributes are collected
/// while walking the node hierarchy and finally printed when printing an
/// `HTMLNode`.
struct AttributedNode: HTML {
    let attribute: Attribute
    let child: HTML
    
    func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        var fullAttrs = attributes
        fullAttrs.append(attribute)
        child.renderAsHTML(into: stream, attributes: fullAttrs)
    }
}

/// MultiNode is an implementation detail for representing multiple sequenced
/// HTML nodes
struct MultiNode: HTML {
    let children: [HTML]
    func renderAsHTML(
        into stream: HTMLOutputStream,
        attributes: [Attribute]
        ) {
        for child in children {
            child.renderAsHTML(into: stream, attributes: attributes)
        }
    }
}
