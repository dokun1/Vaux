//
//  HTMLExtensions.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

/// Strings are HTML nodes that escape their contents and print on a line.
extension String: HTML {
  public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
    for line in split(separator: "\n") {
      stream.writeIndent()
      stream.writeEscaped(line)
      stream.write("\n")
    }
  }
  
  public func getTag() -> String? {
    return nil
  }
}

/// Numeric literals should be interpreted as strings when being written to HTML
extension Int: HTML {
  public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
    let string = String(self)
    string.renderAsHTML(into: stream, attributes: attributes)
  }
  
  public func getTag() -> String? {
    return nil
  }
}

/// Numeric literals should be interpreted as strings when being written to HTML
extension Double: HTML {
  public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
    let string = String(self)
    string.renderAsHTML(into: stream, attributes: attributes)
  }
  
  public func getTag() -> String? {
    return nil
  }
}

/// Numeric literals should be interpreted as strings when being written to HTML
extension Float: HTML {
  public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
    let string = String(self)
    string.renderAsHTML(into: stream, attributes: attributes)
  }
  
  public func getTag() -> String? {
    return nil
  }
}

/// Optionals are HTML nodes if their underlying values are HTML nodes. If the
/// wrapped value is `nil`, it renders to nothing.
extension Optional: HTML where Wrapped: HTML {
  public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
    if let html = self {
      html.renderAsHTML(into: stream, attributes: attributes)
    }
  }
  
  public func getTag() -> String? {
    if let html = self {
      return html.getTag()
    } else {
      return nil
    }
  }
}
