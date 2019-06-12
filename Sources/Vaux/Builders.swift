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
///   - weight: The weight of the heading, such as `<h1>` or `<h4>`. The weight must be specified as between 1 and 6.
///   - child: `HTML` content to go inside the `<h1></h1>` element.
public func heading(weight: Int, @HTMLBuilder child: () -> HTML) -> HTML {
  var weight = weight
  if weight < 1 { weight = 1 }
  if weight > 6 { weight = 6 }
  return HTMLNode(tag: "h\(weight)", child: child())
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
public func link(url: String, label: String) -> HTML {
  return HTMLNode(tag: "a", child: label).attr("href", url)
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

extension HTML {
  /// Allows you to specify a `class` attribute at the end of a HTML element. For example, if you specify `div { "some text" }.class("menu")`, then the rendered HTML will be `<div class="menu">some text</div>`.
  /// - Note: In a HTML document, classes can be reused many times, and are not treated uniquely like ids.
  /// - Parameters:
  ///   - value: The value that will be associated with the `class` tag.
  public func `class`(_ value: String) -> HTML {
    return attr("class", value)
  }
  
  /// Allows you to specify a `id` attribute at the end of a HTML element. For example, if you specify `div { "some text" }.id("12345")`, then the rendered HTML will be `<div id="12345">some text</div>`.
  /// - Warning: In a HTML document, IDs must be considered unique, and cannot be reused.
  /// - Parameters:
  ///   - value: The value that will be associated with the `id` tag.
  public func `id`(_ value: String) -> HTML {
    return attr("id", value)
  }
  
  /// Allows you to specify inline CSS (cascading style sheets) style for a HTML element.
  /// - Note: Inline CSS style on HTML elements is often times frowned upon. It is recommended to instead use a link to a separate stylesheet that is defined on its own. You can do this with the `linkStylesheet()` builder.
  /// - Example: This:
  /// ```
  /// div {
  ///   "some text"
  /// }.style([StyleAttribute(key: "color", value: "blue"])
  /// ```
  /// yields this:
  /// ```
  /// <div style="color:blue">some text</div>
  /// ```
  /// - Parameters:
  ///   - attributes: An array of structs typed `StyleAttribute` that contain a key and value for inline styling.
  public func style(_ attributes: [StyleAttribute]) -> HTML {
    var inlineStyle = String()
    for (index, attribute) in attributes.enumerated() {
      inlineStyle.write(attribute.key)
      inlineStyle.write(":")
      inlineStyle.write(attribute.value)
      if index == 0, attributes.count > 1, index != attributes.count - 1 {
        inlineStyle.write(";")
      }
    }
    return attr("style", inlineStyle)
  }
  
  /// Allows you to specify any attribute at the end of a HTML element. For example, if you specify `div { "some text" }.attr("tag", "123")`, then the rendered HTML will be `<div tag="123">some text</div>`.
  /// - Parameters:
  ///   - key: The tag for the attribute that will be added to this HTML node
  ///   - value: The value that will be associated with the tag.
  public func attr(_ key: String, _ value: String? = nil) -> HTML {
    return AttributedNode(attribute: Attribute(key: key, value: value),
                          child: self)
  }
}
