
# Vaux

<p align="left">
<a href="https://swift.org">
    <img src="https://img.shields.io/badge/swift-5.1-orange.svg" alt="Swift Version">
  </a>
  <a href="https://swift.org/package-manager/">
    <img src="https://img.shields.io/badge/SwiftPM-Tools:5.1-FC3324.svg?style=flat" alt="Swift PM Compatible">
  </a>
  <a href="https://choosealicense.com/licenses/apache/">
    <img src="https://img.shields.io/badge/license-Apache-red.svg" alt="Apache License">
  </a>
</p>

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

## Documentation

_Coming soon..._

## Importing This Library

Vaux is available as a Swift package on GitHub. If you are using the Xcode 11 beta, you can simply add this url (https://github.com/dokun1/Vaux) as a dependency. Otherwise, you must include this as a dependency in your `Package.swift` file and use the command line to to create a project for this.
