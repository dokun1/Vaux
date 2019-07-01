//
//  Builders.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

/// This document should be in alphabetical order.
// MARK: - Builders

// MARK: - A

/// Inserts a `<article>` element into the HTML document, and closes with `</article>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<article></article>` element.
public func article(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "article", child: child())
}

// MARK: - B

/// Inserts a `<blockquote cite="url">` element into the HTML document, and closes with `</blockquote>` after the contents of the closure.
/// - Parameters:
///   - url: The hyperlink source of the quotation.
///   - inline: If true, use the short quotation tag `<q>`.
///   - child: `HTML` content to go inside the `<blockquote></blockquote>` element,
public func blockquote(url: String, inline: Bool = false, @HTMLBuilder child: () -> HTML) -> HTML {
    if inline {
        return HTMLNode(tag: "q", child: child(), inline: true).attr("cite", url)
    } else {
        return HTMLNode(tag: "blockquote", child: child(), inline: false).attr("cite", url)
    }
}

/// Inserts a `<body>` document into the HTML document, and closes with `</body>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<body></body>` element.
public func body(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "body", child: child())
}

// MARK: - C

/// Inserts a `<caption>` element into the HTML document, and closes with `</caption>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<caption></caption>` element.
public func caption(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "caption", child: child())
}

/// Inserts a `<circle/>` element into the SVG element.
/// - Parameters:
///   - radius: radius of the circle.
public func circle(radius: UInt) -> SVG {
    return SVGNode(tag: "circle").attr("r", "\(radius)")
}

/// Inserts a `<cite>` element into the HTML document, and closes with `</cite>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<cite></cite>` element.
public func cite(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "cite", child: child())
}

/// Inserts a `<code>` element into the HTML document, and closes with `</code>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<code></code>` element.
public func code(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "code", child: child())
}

/// Inserts a custom element into the HTML document with your specified tag, and closes with the closing of that tag after the contents of the closure. For example, if you specify `"any-tag"` for the tag, then the HTML element will look like: `<any-tag></any-tag>`
/// - Parameters:
///   - tag: The tag for the element, which can be any `String`.
///   - child: `HTML` content to go inside the HTML element.
public func custom(tag: String, @HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: tag, child: child())
}

/// Inserts a custom self-closing element into the HTML document with your specified tag. For example, if you specify `"any-tag"` for the tag, then the HTML element will look like: `<any-tag/>`
/// - Parameters:
///   - tag: The tag for the element, which can be any `String`.
///   - child: `HTML` content to go inside the HTML element.
public func custom(tag: String) -> HTML {
    return HTMLNode(tag: tag, child: nil)
}

/// Inserts a custom self-closing element into the SVG document with your specified tag. For example, if you specify `"any-tag"` for the tag, then the SVG element will look like: `<any-tag/>`
/// - Parameters:
///   - tag: The tag for the element, which can be any `String`.
///   - child: `SVG` content to go inside the SVG element.
public func customSVG(tag: String) -> SVG {
    return SVGNode(tag: tag)
}

// MARK: - D

/// Inserts a `<div>` element into the HTML document, and closes with `</div>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<div></div>` element.
public func div(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "div", child: child())
}

// MARK: - E

/// Inserts a `<ellipse/>` element into the SVG document.
/// - Parameter horizontalRadius: The horizontal radius of the ellipse.
/// - Parameter verticalRadius: The vertical radius of the ellipse.
public func ellipse(horizontalRadius: UInt, verticalRadius: UInt) -> SVG {
    return SVGNode(tag: "ellipse").attr("ry", "\(verticalRadius)").attr("rx", "\(horizontalRadius)")
}

/// Inserts a `<em>` element into the HTML document, and closes with `</em>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<em></em>` element.
public func emphasis(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "em", child: child())
}

// MARK: - F

/// This allows you to iterate over a collection of data that will be rendered into HTML. By inspecting the variable passed into the closure, you can choose to insert it via a HTML node, or do nothing.
public func forEach<Coll: Collection>(_ data: Coll, @HTMLBuilder content: @escaping (Coll.Element) -> HTML) -> HTML {
  return MultiNode(children: data.map(content))
}

// MARK: - H

/// Inserts a `<head>` element into the HTML document, and closes with `</head>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<head></head>` element.
public func head(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "head", child: child())
}

/// Inserts a `<h1>` element (given the specified weight) into the
/// - Parameters:
///   - weight: The weight of the heading, such as `<h1>` or `<h4>`.
///   - child: `HTML` content to go inside the `<h1></h1>` element.
public func heading(_ weight: HeadingWeight, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: weight.rawValue, child: child())
}

/// Inserts the top level `<html>` element into the HTML document, and closes with `</html>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<html></html>` element.
public func html(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "html", child: child())
}

// MARK: - I

/// Inserts a `<img src="url"/>` element into the HTML document.
/// - Parameter url: The url of the image to show on the webpage.
public func image(url: String) -> HTML {
  return HTMLNode(tag: "img", child: nil).attr("src", url)
}

/// Inserts a `<i>` element into the HTML document, and closes with `</i>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<i></i>` element.
public func italic(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "i", child: child())
}

// MARK: - L

public func line(startX x1: Double, startY y1: Double, endX x2: Double, endY y2: Double) -> SVG {
    return SVGNode(tag: "line")
        .attr("y2", "\(String(format: "%g", y2))")
        .attr("x2", "\(String(format: "%g", x2))")
        .attr("y1", "\(String(format: "%g", y1))")
        .attr("x1", "\(String(format: "%g", x1))")
}

/// Inserts a `<br/>` element into the HTML document.
public func lineBreak() -> HTML {
  return HTMLNode(tag: "br", child: nil)
}

/// Inserts a `<a href="url">` element into the HTML document, and closes with `</a>` after the contents of the closure.
/// - Parameters:
///   - url: The hyperlink that the html link will navigate to when clicked in the web page.
///   - label: The content that will go inside the `<a href=""></a>` element, usually a string of text.
public func link(url: String, label: String, inline: Bool = false) -> HTML {
  return HTMLNode(tag: "a", child: label, inline: inline).attr("href", url)
}

/// Inserts a `<a href="url">` element into the HTML document, and closes with `</a>` after the contents of the closure.
/// - Parameters:
///   - url: The hyperlink that the html link will navigate to when clicked in the web page.
///   - child: `HTML` content to go inside the `<a href=""></a>` element.
/// - Note: If you want to display a text, use the `link:url:label` function instead.
public func link(url: String, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "a", child: child()).attr("href", url)
}

/// Inserts a `<link rel="stylesheet" href="url">` element into the HTML document.
/// - Parameters:
///   - url: The location in your file system where the CSS file is
public func linkStylesheet(url: String) -> HTML {
  return HTMLNode(tag: "link", child: nil).attr("href", url).attr("rel", "stylesheet")
}

/// Inserts a `<ul>` element into the HTML document, and closes with `</ul>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<ul></ul>` element.
public func list(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "ul", child: child())
}

/// Inserts a `<li>` element into the HTML document, and closes with `</li>` after the contents of the closure. These should exist inside of a `list` or `orderedList` closure
/// - Parameters:
///   - label: The content that will go inside the `<li></li>` element, usually a string of text.
public func listItem(label: String) -> HTML {
  return HTMLNode(tag: "li", child: label)
}

// MARK: - O

/// Inserts a `<ol>` element into the HTML document, and closes with `</ol>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<ol></ol>` element.
public func orderedList(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "ol", child: child())
}

// MARK: - P

/// Inserts a `<p>` element into the HTML document, and closes with `</p>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<p></p>` element.
public func paragraph(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "p", child: child())
}

/// Inserts a `<polygon/>` element into the SVG element.
/// - Parameter points: The list of polygon's corners.
public func path(points: [SVGPathControl]) -> SVG {
    return SVGNode(tag: "path").attr("d",
                                        "\(points.compactMap{ "\($0.toString)" }.joined(separator: " "))")
}

/// Inserts a `<polygon/>` element into the SVG element.
/// - Parameter points: The list of polygon's corners.
public func polygon(points: [(x: Double, y: Double)]) -> SVG {
    return SVGNode(tag: "polygon").attr("points",
                                        "\(points.compactMap{ "\(String(format: "%g", $0.x)),\(String(format: "%g", $0.y))" }.joined(separator: " "))")
}

/// Inserts a `<polyline/>` element into the SVG element.
/// - Parameter points: The list of line's points.
public func polyline(points: [(x: Double, y: Double)]) -> SVG {
    return SVGNode(tag: "polyline").attr("points",
                                        "\(points.compactMap{ "\(String(format: "%g", $0.x)),\(String(format: "%g", $0.y))" }.joined(separator: " "))")
}

// MARK: - R

/// Inserts a `<rect/>` element into the SVG element.
/// - Parameters:
///   - width: width of the rectangle.
///   - height: heigth of the rectangle.
public func rectangle(width: UInt, height: UInt) -> SVG {
    return SVGNode(tag: "rect").attr("height", "\(height)").attr("width", "\(width)")
}

// MARK: - S

/// Inserts a `<span>` document into the HTML document, and closes with `</span>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<span></span>` element.
public func span(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "span", child: child())
}

/// Inserts a `<script>...</script>` element into the HTML document for inline scripting.
/// - Parameter child: `HTML`
public func script(code: String) -> HTML {
    return HTMLNode(tag: "script", child: code)
}

/// Inserts a `<script src="src"></scrip>` element into the HTML document.
/// - Parameter src: The localtion of the script to insert.
public func script(filepath: Filepath) -> HTML {
    return HTMLNode(tag: "script", child: "")
      .attr("src", "\(filepath.path)\(filepath.name)")
}

/// Inserts a `<strong>` element into the HTML document, and closes with `</strong>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<strong></strong>` element.
public func strong(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "strong", child: child())
}

/// Inserts a `<sup>` element into the HTML document, and closes with `</sup>` after the contents of the closure. Used to make text look higher than other text.
/// - Parameters:
///   - value: `String` content to go inside the `<sup></sup>` element.
public func superscript(value: String) -> HTML {
  return HTMLNode(tag: "sup", child: value)
}

/// Inserts a `<sub>` element into the HTML document, and closes with `</sub>` after the contents of the closure.  Used to make text look lower than other text.
/// - Parameters:
///   - value: `String` content to go inside the `<sub></sub>` element.
public func `subscript`(value: String) -> HTML {
  return HTMLNode(tag: "sub", child: value)
}

///  Inserts a `<svg>` element into the HTML document, and closes with `</svg>` after the contents of the closure. Used to make text look higher than other text.
/// - Parameter child: `SVG` content to go inside the `<svg></svg>` element.
/// - Todo: Replace HTML content by SVG related tags and content.
public func svg(@SVGBuilder child: () -> SVG) -> HTML {
    return HTMLSVGNode(node: SVGNode(tag: "svg", child: child()))
}

// MARK: - T

/// Inserts a `<table>` element into the HTML document, and closes with `</table>` after the contents of the closure. You may enter whatever you want into further elements, but they must be related to the `<table>` element.
/// - Parameters:
///   - child: `HTML` content to go inside the `<table></table>` element.
public func `table`(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "table", child: child())
}

/// Inserts a `<thead>` element into the HTML document, and closes with `</thead>` after the contents of the closure. You may enter whatever you want into further elements, but they must be related to the `<thead>` elememt.
/// - Parameters:
///   - child: `HTML` content to go inside the `<ul></ul>` element.
public func tableHead(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "thead", child: child())
}

/// Inserts a `<th>` element into the HTML document, and closes with `</th>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<th></th>` element.
public func tableHeadData(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "th", child: child())
}

/// Inserts a `<tbody>` element into the HTML document, and closes with `</tbody>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<tbody></tbody>` element.
public func tableBody(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "tbody", child: child())
}

/// Inserts a `<tr>` element into the HTML document, and closes with `</tr>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<tr></tr>` element.
public func tableRow(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "tr", child: child())
}

/// Inserts a `<td>` element into the HTML document, and closes with `</td>` after the contents of the closure. This is usually the lowest form of signifying a data cell in a HTML table.
/// - Parameters:
///   - child: `HTML` content to go inside the `<td></td>` element.
public func tableData(@HTMLBuilder child: () -> HTML?) -> HTML {
  return HTMLNode(tag: "td", child: child())
}

public func text(_ value: String) -> SVG {
    return SVGNode(tag: "text", child: value)
}

/// Inserts a `<title ="text">` element into the HTML document.
/// - Parameters:
///   - text: The text that will appear inside the `<title></title>` element.
public func title(_ text: String) -> HTML {
  return HTMLNode(tag: "title", child: text)
}
