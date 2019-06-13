//
//  Builders.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

/// Inserts the top level `<html>` element into the HTML document, and closes with `</html>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<html></html>` element.
public func html(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "html", child: child())
}

/// Inserts a `<body>` document into the HTML document, and closes with `</body>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<body></body>` element.
public func body(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "body", child: child())
}

/// Inserts a `<head>` element into the HTML document, and closes with `</head>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<head></head>` element.
public func head(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "head", child: child())
}

/// Inserts a `<div>` element into the HTML document, and closes with `</div>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<div></div>` element.
public func div(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "div", child: child())
}

/// Inserts a `<title ="text">` element into the HTML document.
/// - Parameters:
///   - text: The text that will appear inside the `<title></title>` element.
public func title(_ text: String) -> HTML {
  return HTMLNode(tag: "title", child: text)
}

/// Inserts a `<br/>` element into the HTML document.
public func lineBreak() -> HTML {
  return HTMLNode(tag: "br", child: nil)
}

/// Inserts a `<h1>` element (given the specified weight) into the
/// - Parameters:
///   - weight: The weight of the heading, such as `<h1>` or `<h4>`.
///   - child: `HTML` content to go inside the `<h1></h1>` element.
public func heading(_ weight: HeadingWeight, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: weight.rawValue, child: child())
}

/// Inserts a `<p>` element into the HTML document, and closes with `</p>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<p></p>` element.
public func paragraph(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "p", child: child())
}

/// Inserts a `<em>` element into the HTML document, and closes with `</em>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<em></em>` element.
public func emphasis(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "em", child: child())
}

/// Inserts a `<li>` element into the HTML document, and closes with `</li>` after the contents of the closure. These should exist inside of a `list` or `orderedList` closure
/// - Parameters:
///   - label: The content that will go inside the `<li></li>` element, usually a string of text.
public func listItem(label: String) -> HTML {
  return HTMLNode(tag: "li", child: label)
}

/// Inserts a `<ul>` element into the HTML document, and closes with `</ul>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<ul></ul>` element.
public func list(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "ul", child: child())
}

/// Inserts a `<ol>` element into the HTML document, and closes with `</ol>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<ol></ol>` element.
public func orderedList(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "ol", child: child())
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

/// Inserts a `<img src="url"/>` element into the HTML document.
/// - Parameter url: The url of the image to show on the webpage.
public func image(url: String) -> HTML {
  return HTMLNode(tag: "img", child: nil).attr("src", url)
}

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

/// Inserts a `<caption>` element into the HTML document, and closes with `</caption>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<caption></caption>` element.
public func caption(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "caption", child: child())
}

/// Inserts a custom element into the HTML document with your specified tag, and closes with the closing of that tag after the contents of the closure. For example, if you specify `"any-tag"` for the tag, then the HTML element will look like: `<any-tag></any-tag>`
/// - Parameters:
///   - tag: The tag for the element, which can be any `String`.
///   - child: `HTML` content to go inside the HTML element.
public func custom(tag: String, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: tag, child: child())
}

/// This allows you to iterate over a collection of data that will be rendered into HTML. By inspecting the variable passed into the closure, you can choose to insert it via a HTML node, or do nothing.
public func forEach<Coll: Collection>(_ data: Coll, @HTMLBuilder content: @escaping (Coll.Element) -> HTML) -> HTML {
  return MultiNode(children: data.map(content))
}
