//
//  HTMLNode.swift
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
      stream.write("/>\n")
      return
    }
    
    /// If there is a child, add a new line, and render the child element.
    stream.write(">\n")
    stream.withIndent {
      child.renderAsHTML(into: stream, attributes: [])
    }
    
    /// Add a new line and write the closing tag.
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

public struct StyleAttribute {
  let key: String
  let value: String
}

/// Wraps an HTML object with a given attribute. these attributes are collected
/// while walking the node hierarchy and finally printed when printing an
/// `HTMLNode`.
struct AttributedNode: HTML {
  let attribute: Attribute
  let child: HTML
  
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
/// HTML nodes
struct MultiNode: HTML {
  
  func getTag() -> String? {
    return nil
  }
  
  let children: [HTML]
  func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
    for child in children {
      child.renderAsHTML(into: stream, attributes: attributes)
    }
  }
}

