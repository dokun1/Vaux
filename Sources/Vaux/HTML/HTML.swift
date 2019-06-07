//
//  HTML.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

// MARK: - HTML Protocol and base implementations
/// An object that is capable of rendering itself and its children as HTML, with
/// the provided list of attributes.
public protocol HTML {
  /// Renders the contents of this object as HTML to the provided output stream
  /// as formatted HTML text.
  /// - Parameters:
  ///   - stream: The stream to print the resulting HTML to.
  ///   - attributes: Attributes from `AttributedNode`s higher in the node
  ///                 hierarchy.
  func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute])
  func getTag() -> String?
}
