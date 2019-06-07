# Vaux

Vaux is a domain-specific language written in Swift for HTML. Its purpose is to allow developers to write HTML, but in Swift.

**Warning**: If you are reading this, this is alpha software based Swift 5.1, which is currently only downloadable from [swift.org](https://swift.org) or in Xcode 11 Beta. This is a work in progress in every sense of the phrase.

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

## How to use

Vaux is available as a Swift package on GitHub. If you are using the Xcode 11 beta, you can simply add this url (https://github.com/dokun1/Vaux) as a dependency. Otherwise, you must include this as a dependency in your `Package.swift` file and use the command line to to create a project for this.

More to come...
