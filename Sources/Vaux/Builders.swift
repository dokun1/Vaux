//
//  File.swift
//  
//
//  Created by David Okun on 6/6/19.
//

import Foundation

public func div(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "div", child: child())
}

public func head(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "head", child: child())
}

public func body(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "body", child: child())
}

public func html(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "html", child: child())
}

public func title(_ text: String) -> HTML {
    return HTMLNode(tag: "title", child: text)
}

public func lineBreak() -> HTML {
    return HTMLNode(tag: "br", child: nil)
}

public func heading(weight: Int, @HTMLBuilder child: () -> HTML) -> HTML {
    var weight = weight
    if weight < 1 { weight = 1 }
    if weight > 6 { weight = 6 }
    return HTMLNode(tag: "h\(weight)", child: child())
}

public func paragraph(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "p", child: child())
}

public func emphasis(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "em", child: child())
}

public func list(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "ul", child: child())
}

public func orderedList(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "ol", child: child())
}

public func listItem(label: String) -> HTML {
    return HTMLNode(tag: "li", child: label)
}

public func link(url: String, label: String) -> HTML {
    return HTMLNode(tag: "a", child: label).attr("href", url)
}

public func custom(tag: String, @HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: tag, child: child())
}

/// Iterates over a collection of data and applies a transformation to each
/// piece of data that creates an HTML node.
public func forEach<Coll: Collection>(
    _ data: Coll,
    @HTMLBuilder content: @escaping (Coll.Element) -> HTML
    ) -> HTML {
    return MultiNode(children: data.map(content))
}
