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

/// Wraps multiples SVG filters into a `<filter></filter>` element.
public struct SVGFilter: SVG {
    let node: SVGNode
    let attributes: [Attribute]
    
    public init(id: String,
                types: [SVGFilterType],
                attributes: [Attribute] = []) {
        node = SVGNode(tag: "filter", child: MultiSVGNode(children: types.compactMap{ $0.node }))
        self.attributes = [Attribute(key: "id", value: id)] + attributes
    }
    
    public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        node.renderAsHTML(into: stream, attributes: self.attributes + attributes)
    }

    public func getTag() -> String? {
        return node.getTag()
    }
}

/// Create a SVG linear or radial gradient.
public struct SVGGradient: SVG {
    
    let node: SVGNode
    let attributes: [Attribute]
    
    public enum GradientType {
        case linear
        case radial
    }
    
    /// Create a gradient with full control.
    /// - Parameters:
    ///   - id: The identifier of the gradient. Used to be applied to a SVG element.
    ///   - type: The type of gradient, linear or radial.
    ///   - offsets: The stops for the colors, 2 are needed to get a valid gradient.
    ///   - attributes: A list of attributes to apply to the gradient element. Do not set `id` here.
    public init(id: String,
                type: GradientType,
                offsets: [(offset: String, style: [StyleAttribute])],
                attributes: [Attribute] = []) {
        let stops = offsets.compactMap {
            SVGNode(tag: "stop")
                .attr("offset", $0.offset)
                .style($0.style)
        }
        switch type {
        case .linear:
            node = SVGNode(tag: "linearGradient", child: MultiSVGNode(children: stops))
        case .radial:
            node = SVGNode(tag: "radialGradient", child: MultiSVGNode(children: stops))
        }
        self.attributes = [Attribute(key: "id", value: id)] + attributes
    }
    
    /// Convinent initializer to create a linear gradient.
    public init(id: String,
                controls: (x1: String, y1: String, x2: String, y2: String),
                offsets: [(offset: String, style: [StyleAttribute])]) {
        let stops = offsets.compactMap {
            SVGNode(tag: "stop")
                .attr("offset", $0.offset)
                .style($0.style)
        }
        node = SVGNode(tag: "linearGradient", child: MultiSVGNode(children: stops))
        attributes = [Attribute(key: "id", value: id),
                      Attribute(key: "x1", value: controls.x1),
                      Attribute(key: "y1", value: controls.y1),
                      Attribute(key: "x2", value: controls.x2),
                      Attribute(key: "y2", value: controls.y2)]
    }
    
    /// Convinent initializer to create a radial gradient.
    public init(id: String,
                controls: (cx: String, cy: String, r: String, fx: String, fy: String),
                offsets: [(offset: String, style: [StyleAttribute])]) {
        let stops = offsets.compactMap {
            SVGNode(tag: "stop")
                .attr("offset", $0.offset)
                .style($0.style)
        }
        node = SVGNode(tag: "radialGradient", child: MultiSVGNode(children: stops))
        attributes = [Attribute(key: "id", value: id),
                      Attribute(key: "cx", value: controls.cx),
                      Attribute(key: "cy", value: controls.cy),
                      Attribute(key: "r", value: controls.r),
                      Attribute(key: "fx", value: controls.fx),
                      Attribute(key: "fy", value: controls.fy)]
    }
    
    public func renderAsHTML(into stream: HTMLOutputStream, attributes: [Attribute]) {
        node.renderAsHTML(into: stream, attributes: self.attributes + attributes)
    }
    
    public func getTag() -> String? {
        return node.getTag()
    }
}
