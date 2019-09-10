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

// MARK: - Concatenative HTML Attributes
public struct Attribute {
  public let key: String
  public let value: String?

  public init(key: String, value: String?) {
    self.key = key
    self.value = value
  }

  public init(key: String) {
    self.key = key
    self.value = nil
  }
}

public struct StyleAttribute {
  public let key: String
  public let value: String

  public init(key: String, value: String) {
    self.key = key
    self.value = value
  }
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

public struct TableColumnStyle {
  public let span: Int?
  public let styles: [StyleAttribute]
  
  public init(span: Int? = nil, styles: [StyleAttribute]) {
    self.span = span
    self.styles = styles
  }
}

extension HTML {
  func column(from styles: TableColumnStyle) -> HTML {
    if let span = styles.span {
      return style(styles.styles).attr("span", "\(span)")
    }
    return style(styles.styles)
  }
}
