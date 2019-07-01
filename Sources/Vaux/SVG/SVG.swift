//
//  File.swift
//  
//
//  Created by Mathieu Barnachon on 28/06/2019.
//

import Foundation

// MARK: - SVG Protocol and base implementations
/// An object that is capable of rendering itself and its children as SVG, with
/// the provided list of attributes.
public protocol SVG {
    /// Renders the contents of this object as HTML to the provided output stream
    /// as formatted HTML text.
    /// - Parameters:
    ///   - stream: The stream to print the resulting SVG to.
    ///   - attributes: Attributes from `AttributedNode`s higher in the node
    ///                 hierarchy.
    func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute])
    func getTag() -> String?
}
