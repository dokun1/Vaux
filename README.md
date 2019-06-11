# Vaux

Vaux is a library that allows you to generate HTML using Swift. It includes a domain-specific language written in Swift for HTML, and its purpose is to allow developers to write HTML, but in Swift.

**Warning**: If you are reading this, this is alpha software based on Swift 5.1, which is currently only downloadable from [swift.org](https://swift.org) or in Xcode 11 Beta. This is a work in progress in every sense of the phrase.

## Requirements

- Swift 5.1

## Motivation

At WWDC2019, Apple announced functionality for a new feature in Swift called [Function Builders](https://github.com/rjmccall/swift-evolution/blob/function-builders/proposals/XXXX-function-builders.md). The core functionality of Vaux, which includes a Swift DSL for HTML, is heavily inspired by this proposal and corresponding examples. As such, this library exists with two primary goals:

- Provide an underpinning for future potential opinionated frameworks for web interfaces written in Swift.
- Learn more about function builders.

At the time of this library's first open source release, it is standing tall on the shoulders of giants, and gratitude is in order.

## Example

Let's say you want to write the following HTML:

```html
<html>
  <head>
    <title>
      Page title
    </title>
  </head>
  <body>
    <div>
      Page body
    </div>
  </body>
</html>
```

Rather than write this out by hand, you can first write a function that will return HTML using Vaux:

```swift
var pageTitle = "Page title"
var pageBody = "Page body"

func simplePage() -> HTML {
  html {
    head {
      title(pageTitle)
    }
    body {
      div {
        pageBody
      }
    }
  }
}
```

Then, you can render the function result into a static html file using Vaux like so:

```swift
let vaux = Vaux()
vaux.outputLocation = .file(name: "testing", path: "/tmp/")
do {
  try vaux.render(html)
} catch let error {
  print("Uh-oh, something happened: \(error.localizedDescription)")
}
```

The end result is that you have a file called `testing.html` in your `/tmp/` directory.

## Creating HTML elements

**Note**: For a series of real use cases for Vaux, check out `VauxTests.swift` to see examples of different tags.

Write a function that returns `HTML`, and add your builders inside this function:

```swift
func buildPage() -> HTML {

}
```

### `<html/>`

All other builders in Vaux must include this element, which is declared like so:

```swift
func buildPage() -> HTML {
  html {
    "hello"
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  hello
</html>
```

### `<body/>`

In HTML, the body element is for content that goes in the main portion of your webpage. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    body {
      "hello"
    }
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <body>
    hello
  </body>
</html>
```

### `<head/>`

In HTML, the head is focused on specifying content that is at the top of your document. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    head {
      "hello"
    }
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <head>
    hello
  </head>
</html>
```

### `<div/>`

In HTML, a div is used for any number of elements, and can be fully customized to meet your needs with [attributes](). In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    div {
      "hello"
    }
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <div>
    hello
  </div>
</html>
```

### `<title/>`

In HTML, a title is used to specify the title of your web page. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    title("Page title")
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <title>
    Page title
  </title>
</html>
```

### `<br/>`

In HTML, a line break is used to add a line break between lines of text or other elements. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    lineBreak()
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <br/>
</html>
```

### `<h1/>` - `<h6/>`

In HTML, a heading is used to specify the weight of certain text, to create a natural heading for content in your page. You can only specify a heading weight between 1 and 6. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    heading(weight: 2) {
      "This is a header"
    }
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <h2>
    This is a header
  </h2>
</html>
```

### `<p/>`

In HTML, a paragraph is a built in element to delineate a paragraph of text. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    paragraph {
      "Four score and seven years ago..."
    }
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <p>
    Four score and seven years ago...
  </p>
</html>
```

### `<em/>`

In HTML, you can insert an emphasis tag to emphasize  (or italicize) text wrapped in the tags. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    emphasis {
      "Four score and seven years ago..."
    }
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <em>
    Four score and seven years ago...
  </em>
</html>
```

### `<li/>`

In HTML, a list item is an element that rests inside a list. It will exhibit behavior that is contextually consistent with the type of list it is in - ordered or unordered. Examples that use the list item will follow in the next two list examples.

### `<ul/>` & `<ol/>`

In HTML, an unordered list is a rendered list of list items that show as bullet points. In your Swift function, write this:

```swift 
func buildPage() -> HTML {
  html {
    list {
      forEach(1...3) { counter in
        listItem(label: "item #\(counter)")
      }
    }
  }
}
```

Note that this is also an example of the `forEach` functionality, qwhich allows you to loop through a collection of data. Without this function, you could render HTML like so:

```swift
func buildPage() -> HTML {
  html {
    list {
      listItem(label: "item #1")
      listItem(label: "item #2")
      listItem(label: "item #3")
    }
  }
}
```
Ultimately, this HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <ul>
    <li>
      item #1
    </li>
    <li>
      item #2
    </li>
    <li>
      item #3
    </li>
  </ul>
</html>
```

In HTML, an ordered list rendered the same as an unordered list, but the prefix to each item in the final rendered HTML is numbered. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    orderedList {
      listItem(label: "item #1")
      listItem(label: "item #2")
      listItem(label: "item #3")
    }
  }
}
```
Ultimately, this HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <ol>
    <li>
      item #1
    </li>
    <li>
      item #2
    </li>
    <li>
      item #3
    </li>
  </ol>
</html>
```

### `<a href/>`

In HTML, you can add functionality for a hyperlink to another web address by specifying both a location and a label. The `a` in this link stands for "anchor", and the `href` stands for `H`ypertext `REF`erence. This means that you can use the `custom` tag to specify anchors for other use cases, but links are common enough to warrant their own functions. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    link(url: "https://david.okun.io", label: "My Website")
  }
}
```
This HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <a href="https://david.okun.io">
    My Website
  </a>  
</html>
```

### `<link rel="stylesheet">`

In HTML, you can specify the use of a specific CSS (cascading style sheet) specification outside the scope of this HTML document. You just need to know the name and relative location of this file. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    linkStylesheet(url: "/tmp/style.css")
  }
}
```
This HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <link rel="stylesheet" href="/tmp/style.css"/>
</html>
```

### <script/>

You can extend HTML with scripting languages, like `javascript`. It is a common practice, and it allows a lot of possibilities.
In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    script(code: "var i = 0;")
  }
}
```
or using multiline strings:

```swift
func buildPage() -> HTML {
  html {
    script(code: """
      var i = 0;
      """)
  }
}
```
**Note that currently, using the multiline strings, you cannot use double quotes or they will be escaped!**

This HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <script>
    var i = 0;
  </script>
</html>
```

A script can also be included by its URL. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    linkScript(src: "script.js")
  }
}
```
This HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <script url="script.js">
  </script>
</html>
```


### Custom HTML Tags

This library aims to cover all possible HTML tags. As this library grows, it is important to have a tag that allows you to create any tag you need. Thus, the `custom()` function exists. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    custom(tag: "any-tag") {
      "Custom tag text goes here"
    }
  }
}
```
This HTML will render like so:

```html
<!DOCTYPE html>
<html>
  <any-tag>
    Custom tag text goes here
  </any-tag>
</html>
```

## Adding HTML Attributes

Vaux allows you to add any HTML attribute you want to any element declared in the documentation above.

### `class="myClass"`

In HTML, you can specify a class for any given element you want. This is most commonly done for `div`s, and these values can be reused. If you want to add a `class` attribute to a HTML element, write this:

```swift
func buildPage() -> HTML {
  html {
    div {
      "Custom tag text goes here"
    }.class("my-class")
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <div class="my-class">
    Custom tag text goes here
  </div>
</html>
```

### `id="myID"`

In HTML, you can specify an id for any given element you want. This is most commonly done for `div`s, and these values cannot be reused more than once in your HTML document. If you want to add a `id` attribute to a HTML element, write this:

```swift
func buildPage() -> HTML {
  html {
    div {
      "Custom tag text goes here"
    }.id("abcd")
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <div id="abcd">
    Custom tag text goes here
  </div>
</html>
```

### `style="key:value"`

In HTML, you can specify inline CSS styling for any given element you want. This is most commonly done for `div`s. It is recommended to use a pre-existing CSS file outside the scope of the HTML document, but this functionality is possible, nonetheless. If you want to add a `style` attribute to a HTML element, write this:

```swift
func buildPage() -> HTML {
  html {
    div {
      "Custom tag text goes here"
    }.style([StyleAttribute(key: "background-color", value: "blue"),
             StyleAttribute(key: "color", value: "red")])
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <div style="background-color:blue;color:red">
    Custom tag text goes here
  </div>
</html>
```

### Custom attributes

This library aims to cover all possible HTML attributes. As this library grows, it is important to have the ability to allow you to create any attribute you need. In your Swift function, write this:

```swift
func buildPage() -> HTML {
  html {
    div {
      "Custom tag text goes here"
    }.attr("key", "value")
  }
}
```

This will render like so:

```html
<!DOCTYPE html>
<html>
  <div key="value">
    Custom tag text goes here
  </div>
</html>
```

## Importing This Library

Vaux is available as a Swift package on GitHub. If you are using the Xcode 11 beta, you can simply add this url (https://github.com/dokun1/Vaux) as a dependency. Otherwise, you must include this as a dependency in your `Package.swift` file and use the command line to to create a project for this.
