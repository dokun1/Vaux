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

/// Inserts a `<abbr>` element into the HTML document and closes with `</abbr>` after the contents of the closure.
/// - Parameter title: The definition of the abbreviation
/// - Parameter child: Usually the abbreviation or accronym itself.
public func abbreviation(title: String, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "abbr", child: child()).attr("title", title)
}

/// Inserts a `<address>` element into the HTML document and closes with `</address>` after the contents of the closure.
/// - Parameter child: The address to print.
/// - Note: If the address is inside a `<body>` element, it represents the contact information of the document.
/// - Note: If teh address is inside a `<article>` element, it represents the contact information for the article. See [article](x-source-tag://article).
/// - Tag: address
public func address(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "address", child: child())
}

/// Inserts a `<area shape coords href/>` element into the HTML document
/// - Parameter shape: Shape of the clickable area.
/// - Parameter coords: The coordinates (depends on the shape).
/// - Parameter url: The link when the area is clicked.
/// - Note: The area is always nested inside a `<map>` tag. See [map](x-source-tag://map).
/// - Tag: area
public func area(shape: AreaShape, coords: [Double], url: String) -> HTML {
  return HTMLNode(tag: "area", child: nil)
    .attr("href", url)
    .attr("coords", coords.map{ String(format: "%g", $0) }.joined(separator: ","))
    .attr("shape", shape.rawValue)
}

/// Inserts a default `<area>` element into the HTML document.
/// - Parameter url: The link when the area is clicked.
/// - Note: This function inserts the `default` type which makes the whole area clickable.
public func area(url: String) -> HTML {
  return HTMLNode(tag: "area", child: nil)
    .attr("shape", AreaShape.default.rawValue)
    .attr("href", url)
}

/// Inserts a rectangular `<area>` element into the HTML document.
/// - Parameter rectangle: The coordinates of the rectangle.
/// - Parameter url: The link when the area is clicked.
public func area(rectangle: (x1: Int, y1: Int, x2: Int, y2: Int), url: String) -> HTML {
  return HTMLNode(tag: "area", child: nil)
    .attr("href", url)
    .attr("coords", "\(rectangle.x1),\(rectangle.y1),\(rectangle.x2),\(rectangle.y2)")
    .attr("shape", AreaShape.rectangular.rawValue)
}

/// Inserts a circular `<area>` element into the HTML document.
/// - Parameter circle: The circle definition with center (X, Y) and the radius.
/// - Parameter url: The link when the area is clicked.
public func area(circle: (x: Int, y: Int, radius: Double), url: String) -> HTML {
  return HTMLNode(tag: "area", child: nil)
    .attr("href", url)
    .attr("coords", "\(circle.x),\(circle.y),\(String(format: "%g", circle.radius))")
    .attr("shape", AreaShape.circle.rawValue)
}

/// Inserts a `<article>` element into the HTML document, and closes with `</article>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<article></article>` element.
public func article(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "article", child: child())
}

public func audio(sources: [(url: String, type: MIME)], unsupportedLabel: String) -> HTML {
  let sourceTags = sources.map{ HTMLNode(tag: "source").attr("type", $0.type.rawValue).attr("src", $0.url)}
  return HTMLNode(tag: "audio", child: MultiNode(children: sourceTags + [unsupportedLabel]))
}

// MARK: - B

/// Inserts a `<base/>` element into the HTML document.
/// - Parameter url: The base URL for relative URLs in the page.
/// - Parameter target: The default target for all hyperlinks and forms in the page.
/// - Note: There must be only one `<base/>` per document, located inside the `<head></head>` section.
public func base(url: String, target: BaseTarget) -> HTML {
  return HTMLNode(tag: "base", child: nil).attr("target", target.toString).attr("href", url)
}

/// Inserts a `<base/>` element into the HTML document.
/// - Parameter url: The base URL for relative URLs in the page.
/// - Note: There must be only one `<base/>` per document, located inside the `<head></head>` section.
public func base(url: String) -> HTML {
  return HTMLNode(tag: "base", child: nil).attr("href", url)
}

/// Inserts a `<base/>` element into the HTML document.
/// - Parameter target: The default target for all hyperlinks and forms in the page.
/// - Note: There must be only one `<base/>` per document, located inside the `<head></head>` section.
public func base(target: BaseTarget) -> HTML {
  return HTMLNode(tag: "base", child: nil).attr("target", target.toString)
}

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

/// Inserts a `<b>` element into the HTML document and closes with `</b>` after the contents of the closure.
/// - Parameter child: `HTML` content to go inside the `<b></b>` element.
/// - Note: (from w3schools.com) According to the HTML 5 specification, the `<b>` tag should be used as a LAST resort when no other tag is more appropriate. The HTML 5 specification states that headings should be denoted with the `<h1>` to `<h6>` tags, emphasized text should be denoted with the `<em>` tag, important text should be denoted with the `<strong>` tag, and marked/highlighted text should use the `<mark>` tag.
/// See [emphasis](x-source-tag://emphasis), [mark](x-source-tag://mark), [strong](x-source-tag://strong), [heading](x-source-tag://heading).
/// - Tag: bold
public func bold(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "b", child: child())
}

/// Inserts a `<button>` elements into the HTML document, and closes with `</button>` after the contents of the closure.
/// - Parameter type: The type of button
/// - Parameter child: `HTML` content to go inside the `<button></button>` element.
public func button(type: ButtonType, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "button", child: child()).attr("type", type.rawValue)
}

// MARK: - C

/// Inserts a `<caption>` element into the HTML document, and closes with `</caption>` after the contents of the closure. Each element in the closure must be of type `listItem`.
/// - Parameters:
///   - child: `HTML` content to go inside the `<caption></caption>` element.
public func caption(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "caption", child: child())
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

/// Inserts a `<colgroup>` element into the HTML document, and closes with `</colgroup>` after the list of column specifications.
/// - Parameter styles: The list of style for the column. It supports spanning over multiple columns.
/// - Note: With this function you don't need to craft your `<col/>` tags, they are made out of the `TableColumnStyle` list.
public func columnGroup(styles: [TableColumnStyle]) -> HTML {
  let colorsTags = styles.map{ HTMLNode(tag: "col").column(from: $0) }
  return HTMLNode(tag: "colgroup", child: MultiNode(children: colorsTags))
}

/// Inserts a custom element into the HTML document with your specified tag, and closes with the closing of that tag after the contents of the closure. For example, if you specify `"any-tag"` for the tag, then the HTML element will look like: `<any-tag></any-tag>`
/// - Parameters:
///   - tag: The tag for the element, which can be any `String`.
///   - child: `HTML` content to go inside the HTML element.
public func custom(tag: String, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: tag, child: child())
}

// MARK: - D

/// Inserts a `<data>` element into the HTML document, and closes with `</data>` after the contents of the closure.
/// - Parameter value: The machine readable value
/// - Parameter child: `HTML` content to go inside the `<data></data>` element, usually the name.
public func data(value: String, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "data", child: child()).attr("value", value)
}

/// Inserts a `<datalist>` element into the HTML document, and closes with `</datalist>` after the contents of the closure.
/// - Parameter list: The option list.
/// - Parameter id: The reference to the `<input/>` id.
public func data(list: [String], id: String) -> HTML {
  let optionList = list.map{ HTMLNode(tag: "option").attr("value", $0) }
  return HTMLNode(tag: "datalist", child: MultiNode(children: optionList)).attr("id", id)
}

/// Inserts a `<dt>` element into the HTML document, and closes with `</dt>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside the `<dt></dt>` element, usually the term described.
/// - Note: To use with [describe](x-source-tag://describe) and [descriptionList](x-source-tag://descriptionList).
/// - Tag: define
public func define(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "dt", child: child())
}

/// Inserts a `<dfn>` element into the HTML document, and closes with `</dfn>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside `<dfn></dfn>` element.
public func defining(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "dfn", child: child())
}

/// Inserts a `<del>` element into the HTML document, and closes with `</del>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside `<del></del>` element, usually the deleted text.
/// - Note: Use [insert](x-source-tag://insert) for the content replacing it.
/// - Tag: delete
public func delete(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "del", child: child())
}

/// Inserts a `<details>` element into the HTML document, and closes with `</details>` after the contents of the closure.
/// - Parameter open: If true, the description should be shown open.
/// - Parameter child: The `HTML` content to go inside `<details></details>` element, usually using the `<summary></summary>` tag.
/// - Note: See [summary](x-source-tag://summary) to add the summary of the details.
/// - Tag: details
public func details(open: Bool = false, @HTMLBuilder child: () -> HTML) -> HTML {
    if open {
        return HTMLNode(tag: "details", child: child()).attr("open")
    } else {
        return HTMLNode(tag: "details", child: child())
    }
}

/// Inserts a `<dd>` element into the HTML document, and closes with `</dd>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside the `<dd></dd>` element, usually the term described.
/// - Note: To use with [define](x-source-tag://define) and [descriptionList](x-source-tag://descriptionList).
/// - Tag: describe
public func describe(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "dd", child: child())
}

/// Inserts a `<dl>` elements into the HTML document, and closes with `</dl>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside the `<dl></dl>` elements. Must be a set of `<dd></dd>` and `<dt></dt>`.
/// - Note: Use [describe](x-source-tag://describe) and [define](x-source-tag://describe) to define and describe the list.
/// - Tag: descriptionList
public func descriptionList(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "dl", child: child())
}

/// Inserts a `<dialog>` elements into the HTML document, and closes with `<dialog>` after the contents of the closure.
/// - Parameter open: Specify that the dialog is open for user interaction.
/// - Parameter child: The `HTML` content to go inside the `<dialog></dialog>` elements.
public func dialog(open: Bool, @HTMLBuilder child: () -> HTML) -> HTML {
    if open {
        return HTMLNode(tag: "dialog", child: child()).attr("open")
    }
    return HTMLNode(tag: "dialog", child: child())
}

/// Inserts a `<bdo>` elements into the HTML document, and closes with `</bdo>` after the contents of the closure.
/// - Parameter direction: The direction to use, either left-to-right or right-to-left.
/// - Parameter child: `HTML` conten to go inside the `<bdo></bdo>` element.
public func directional(direction: Direction, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "bdo", child: child()).attr("dir", direction.rawValue)
}

/// Inserts a `<div>` element into the HTML document, and closes with `</div>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<div></div>` element.
public func div(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "div", child: child())
}

// MARK: - E

/// Inserts a `<em>` element into the HTML document, and closes with `</em>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<em></em>` element.
/// - Tag: emphasis
public func emphasis(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "em", child: child())
}

// MARK: - F

/// This allows you to iterate over a collection of data that will be rendered into HTML. By inspecting the variable passed into the closure, you can choose to insert it via a HTML node, or do nothing.
public func forEach<Coll: Collection>(_ data: Coll, @HTMLBuilder content: @escaping (Coll.Element) -> HTML) -> HTML {
  return MultiNode(children: data.map(content))
}

public func form(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "form", child: child())
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
/// - Tag: heading
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

/// Inserts a `<input>` element into the HTML document, and closes with `</input>` after the contents of the closure.
/// - Parameter type: The type of input.
public func input(type: InputType? = nil) -> HTML {
    if let type = type {
        return HTMLNode(tag: "input", child: nil).attr("type", type.rawValue)
    }
    return HTMLNode(tag: "input", child: nil)
}

/// Inserts a `<ins>` element into the HTML document, and closes with `</ins>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside the `<ins></ins>` element.
public func insert(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "ins", child: child())
}

/// Inserts a `<i>` element into the HTML document, and closes with `</i>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<i></i>` element.
public func italic(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "i", child: child())
}

// MARK: - L

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
/// - Note: To render some `HTML` inside the list item, use [listChildItem](x-source-tag://listChildItem)
/// - Tag: listItem
public func listItem(label: String) -> HTML {
  return HTMLNode(tag: "li", child: label)
}

/// Inserts a `<li>` element into the HTML document, and closes with `</li>` after the contents of the closure. These should exist inside of a `list` or `orderedList` closure
/// - Parameters:
///   - child: The content that will go inside the `<li></li>` element.
/// - Note: For the usual string of text, prefer [listItem](x-source-tag://listItem)
/// - Tag: listChildItem
public func listItem(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "li", child: child())
}

// MARK: - M

/// Inserts a `<map>` elements into the HTML document and closes with `</map>` after the contents of the closure. Each element in the closure must be of type `area`.
/// - Parameter name: The name of the map.
/// - Parameter child: The `area` elements on that map.
/// - Note: The nested elements are constructed from [area](x-source-tag://area).
/// - Tag: map
public func map(name: String, @HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "map", child: child()).attr("name", name)
}

/// Inserts a `<mark>` elements into the HTML documents and closes with `</mark>` after the contents of the closure.
/// - Parameter child: `HTML` content to go inside the `<mark></mark>` element.
public func mark(@HTMLBuilder child: () -> HTML) -> HTML {
  return HTMLNode(tag: "mark", child: child())
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

// MARK: - S

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

/// Inserts a `<span>` document into the HTML document, and closes with `</span>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<span></span>` element.
public func span(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "span", child: child())
}

/// Inserts a `<strong>` element into the HTML document, and closes with `</strong>` after the contents of the closure.
/// - Parameters:
///   - child: `HTML` content to go inside the `<strong></strong>` element.
/// - Tag: strong
public func strong(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "strong", child: child())
}

/// Add a `<summary>` element into the HTML document and closes with `</summary>` after the contents of the closure.
/// - Parameter child: The `HTML` content to go inside the `<summary></summary>` element.
/// - Note: It should be the first element inside a [details](x-source-tag://details) element.
/// - Tag: summary
public func summary(@HTMLBuilder child: () -> HTML) -> HTML {
    return HTMLNode(tag: "summary", child: child())
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

/// Inserts a `<title ="text">` element into the HTML document.
/// - Parameters:
///   - text: The text that will appear inside the `<title></title>` element.
public func title(_ text: String) -> HTML {
  return HTMLNode(tag: "title", child: text)
}
