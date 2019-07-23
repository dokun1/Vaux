//
//  Attributes.swift
//  
//
//  Created by David Okun on 6/13/19.
//

import Foundation

extension HTML {

  /// Allows you to specify an `align` attribute at the end of a HTML element. For example, if you specify `div { "some text" }.align(.center)`, then the rendered HTML will be `<div align="center">some text</div>`.
  /// - Note: Alignment can affect multiple different elements with different behavior based on their containing elements. Best practice is to offload this to the associated CSS file.
  /// - Parameters:
  ///   - value: The value that will be associated with the `align` tag.
  public func alignment(_ value: Alignment) -> HTML {
    return attr("align", value.rawValue)
  }
  
  /// Allows you to specify any attribute at the end of a HTML element. For example, if you specify `div { "some text" }.attr("tag", "123")`, then the rendered HTML will be `<div tag="123">some text</div>`.
  /// - Parameters:
  ///   - key: The tag for the attribute that will be added to this HTML node
  ///   - value: The value that will be associated with the tag.
  /// - Tag: attr
  public func attr(_ key: String, _ value: String? = nil) -> HTML {
    return AttributedNode(attribute: Attribute(key: key, value: value),
                          child: self)
  }
  
  /// Allows you to specify a `bgcolor` attribute at the end of a HTML element. For example, if you specify `div { "some text" }.backgroundColor("555555")`, then the rendered HTML will be `<div bgcolor="555555">some text</div>`.
  /// - Note: Background color is generally better to set in your associated CSS file. The hex code must be a 6 character hexadecimal string.
  /// - Warning: This will eventually be refactored to allow for use of specific colors that convert to hex codes via an enum. UIColor() must not be used, which would limit this library to iOS only.
  /// - Parameters:
  ///   - hexCode: The value that will be used to describe the color associated with the `bgcolor` tag.
  public func backgroundColor(_ hexCode: String) -> HTML {
    return attr("bgcolor", hexCode)
  }

  /// Allows you to specify a `class` attribute at the end of a HTML element. For example, if you specify `div { "some text" }.class("menu")`, then the rendered HTML will be `<div class="menu">some text</div>`.
  /// - Note: In a HTML document, classes can be reused many times, and are not treated uniquely like ids.
  /// - Parameters:
  ///   - value: The value that will be associated with the `class` tag.
  public func `class`(_ value: String) -> HTML {
    return attr("class", value)
  }

  /// Allows you to specify a `color` attribute at the end of a HTML element. For example, if you specify `span { "some text" }.color("555555")`, then the rendered HTML will be `<span color="555555">some text</span>`.
  /// - Note: Color, mostly used with text, is generally better to set in your associated CSS file. The hex code must be a 6 character hexadecimal string.
  /// - Warning: This will eventually be refactored to allow for use of specific colors that convert to hex codes via an enum. UIColor() must not be used, which would limit this library to iOS only.
  /// - Parameters:
  ///   - hexCode: The value that will be used to describe the color associated with the `color` tag.
  public func color(_ hexCode: String) -> HTML {
    return attr("color", hexCode)
  }

  /// Allows you to specify a `colspan` attribute at the end of a HTML element. For example, if you specify `tableData { "some text" }.columnSpan(4)`, then the rendered HTML will be `<td colspan="4">some text</td>`.
  /// - Note: In a HTML table, colspan is used to define how many columns a particular element should go across. This is easier to see when you have clearly defined borders and cell padding for your table.
  /// - Parameters:
  ///   - value: The value that will be associated with the `colspan` tag.
  public func columnSpan(_ value: Int) -> HTML {
    return attr("colspan", String(value))
  }

  /// Allows you to specify a `id` attribute at the end of a HTML element. For example, if you specify `div { "some text" }.id("12345")`, then the rendered HTML will be `<div id="12345">some text</div>`.
  /// - Warning: In a HTML document, IDs must be considered unique, and cannot be reused.
  /// - Parameters:
  ///   - value: The value that will be associated with the `id` tag.
  public func `id`(_ value: String) -> HTML {
    return attr("id", value)
  }

  /// Allows you to specify a `rowspan` attribute at the end of a HTML element. For example, if you specify `tableData { "some text" }.rowSpan(4)`, then the rendered HTML will be `<td rowspan="4">some text</td>`.
  /// - Note: In a HTML table, rowspan is used to define how many rows a particular element should go across. This is easier to see when you have clearly defined borders and cell padding for your table.
  /// - Parameters:
  ///   - value: The value that will be associated with the `rowspan` tag.
  public func rowSpan(_ value: Int) -> HTML {
    return attr("rowspan", String(value))
  }

  /// Allows you to specify a `scope` attribute at the end of a HTML element. For example, if you specify `tableData { "some text" }.scope(.row)`, then the rendered HTML will be `<td scope="row">some text</td>`.
  /// - Note: The scope attribute identifies whether a cell is a header for a column, row, or group of columns or rows.
  /// - Parameters:
  ///   - value: The value that will be associated with the `scope` tag.
  public func scope(_ value: Scope) -> HTML {
    return attr("scope", value.rawValue)
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
    for attribute in attributes {
      inlineStyle.write(attribute.key)
      inlineStyle.write(":")
      inlineStyle.write(attribute.value)
      inlineStyle.write(";")
    }
    return attr("style", inlineStyle)
  }

  /// Allow you to specify a media type for a HTML element.
  ///
  /// This could  be used for link,  script, input, and any other tags which support it.
  /// - Note: Look at IANA Media Types for a complete list of standard media types.
  /// - Example: This:
  /// ```
  /// linkStyleSheet(url: "style.css").type("text/css")
  /// ```
  /// yields this:
  /// ```
  /// <link type="text/css" rel="stylesheet" href="style.css"/>
  /// ```
  /// - Parameter mime: The Internet media type of the linked document.
  public func type(_ mime: String) -> HTML {
    return attr("type", mime)
  }

  public func type(_ mime: MIME) -> HTML {
    return attr("type", mime.rawValue)
  }
}

extension SVG {
  
  /// Allows you to specify any attribute at the end of a SVG element. For example, if you specify `circle().attr("tag", "123")`, then the rendered HTML will be `<circle tag="123"/>`.
  /// - Parameters:
  ///   - key: The tag for the attribute that will be added to this SVG node
  ///   - value: The value that will be associated with the tag.
  public func attr(_ key: String, _ value: String? = nil) -> SVG {
    return AttributedSVGNode(attribute: Attribute(key: key, value: value),
                             child: self)
  }
  
  /// Allows you to specify inline CSS (cascading style sheets) style for a SVG element.
  /// - Note: Inline CSS style on SVG elements is often times frowned upon. It is recommended to instead use a link to a separate stylesheet that is defined on its own. You can do this with the `linkStylesheet()` builder.
  /// - Example: This:
  /// ```
  /// circle(radius: 40)
  ///   .style([StyleAttribute(key: "fill", value: "rgb(0,0,255)"])
  /// ```
  /// yields this:
  /// ```
  /// <circle style="fill:rgb(0,0,255)" r="40"/>
  /// ```
  /// - Parameters:
  ///   - attributes: An array of structs typed `StyleAttribute` that contain a key and value for inline styling.
  public func style(_ attributes: [StyleAttribute]) -> SVG {
    var inlineStyle = String()
    for (index, attribute) in attributes.enumerated() {
      inlineStyle.write(attribute.key)
      inlineStyle.write(":")
      inlineStyle.write(attribute.value)
      if attributes.count > 1, index != attributes.count - 1 {
        inlineStyle.write(";")
      }
    }
    return attr("style", inlineStyle)
  }
  
  public func position(left x: Double, top y: Double) -> SVG {
    return self.attr("y", "\(String(format: "%g", y))").attr("x", "\(String(format: "%g", x))")
  }
  
  public func position(centerX cx: Double, centerY cy: Double) -> SVG {
    return self.attr("cy", "\(String(format: "%g", cy))").attr("cx", "\(String(format: "%g", cx))")
  }
}
