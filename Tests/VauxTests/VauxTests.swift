//
//  VauxTests.swift
//
//
//  Created by David Okun on 6/6/19.
//

import XCTest
@testable import Vaux

final class VauxTests: XCTestCase {
  func testSimplePage() {
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
    let correctHTML = """
    <!DOCTYPE html>
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
    """.replacingOccurrences(of: "\n", with: "")
    
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: simplePage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testHTMLSpecial() {
    var pageTitle = "Page title"
    var pageBody = "It is 60&deg;F (15.6&deg;C) outside."
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
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <head>
        <title>
          Page title
        </title>
      </head>
      <body>
        <div>
          It is 60&deg;F (15.6&deg;C) outside.
        </div>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: simplePage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testLinkInline() {
    var url = "https://google.com"
    func pageWithLink() -> HTML {
      html {
        body {
          link(url: url, label: "google", inline: true)
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <a href="\(url)">google</a>
        </body>
      </html>
      """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithLink())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testLink() {
    var url = "https://google.com"
    func pageWithLink() -> HTML {
      html {
        body {
          link(url: url, label: "google")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <a href="\(url)">
            google
          </a>
        </body>
      </html>
      """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithLink())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testLinkWithChild() {
    var url = "https://google.com"
    func pageWithLink() -> HTML {
      html {
        body {
          link(url: url) {
            paragraph {
              "google"
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <a href="\(url)">
            <p>
              google
            </p>
          </a>
        </body>
      </html>
      """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithLink())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testLinebreak() {
    func pageWithLinebreak() -> HTML {
      html {
        body {
          lineBreak()
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <br/>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithLinebreak())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testArticle() {
    func pageWithArticle() -> HTML {
      html {
        body {
          article {
            "This is an article"
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <article>
          This is an article
        </article>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithArticle())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testSpan() {
    func pageWithSpan() -> HTML {
      html {
        body {
          paragraph {
            "When I was"
            span {
              "a young boy,"
              }.style([StyleAttribute(key: "color", value: "blue")])
            "my father took me into the city."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          When I was
          <span style="color:blue">
            a young boy,
          </span>
          my father took me into the city.
        </p>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithSpan())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testEmphasis() {
    func pageWithLink() -> HTML {
      html {
        body {
          paragraph {
            "Four score and"
            emphasis { "seven" }
            "years ago..."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          Four score and
          <em>
            seven
          </em>
          years ago...
        </p>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithLink())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testTextHighlighting() {
    func formattedPage() -> HTML {
      html {
        body {
          paragraph {
            "Four score and"
            italic { "seven" }
            "years ago..."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          Four score and
          <i>
            seven
          </i>
          years ago...
        </p>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: formattedPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testTextStrong() {
    func formattedPage() -> HTML {
      html {
        body {
          paragraph {
            "Four score and"
            strong { "seven" }
            "years ago..."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          Four score and
          <strong>
            seven
          </strong>
          years ago...
        </p>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: formattedPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testTextCite() {
    func formattedPage() -> HTML {
      html {
        body {
          paragraph {
            cite { "The Scream" }
            "by Edward Munch. Painted in 1893."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          <cite>
            The Scream
          </cite>
          by Edward Munch. Painted in 1893.
        </p>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: formattedPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testTextBlockquote() {
    func formattedPage() -> HTML {
      html {
        body {
          heading(.h1) {
            "About Swift"
          }
          blockquote(url: "https://swift.org/about/", inline: true) {
            "The most obvious way to write code should also behave in a safe manner."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <h1>
          About Swift
        </h1>
        <q cite="https://swift.org/about/">The most obvious way to write code should also behave in a safe manner.</q>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: formattedPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testTextShortQuote() {
    func formattedPage() -> HTML {
      html {
        body {
          heading(.h1) {
            "About Swift"
          }
          blockquote(url: "https://swift.org/about/") {
            "Swift is a general-purpose programming language built using a modern approach to safety, performance, and software design patterns."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <h1>
          About Swift
        </h1>
        <blockquote cite="https://swift.org/about/">
          Swift is a general-purpose programming language built using a modern approach to safety, performance, and software design patterns.
        </blockquote>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: formattedPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testTextCode() {
    func formattedPage() -> HTML {
      html {
        body {
          code {
            """
            html {
              body {
                code {
                  ...
                }
              }
            }
            """
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <code>
          html {
            body {
              code {
                ...
              }
            }
          }
        </code>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: formattedPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testStdout() {
    func buildPage() -> HTML {
      html {
        div {
          "Custom tag text goes here"
          }.class("my-class")
      }
    }
    do {
      try Vaux().render(buildPage())
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testLists() {
    func pageWithLists() -> HTML {
      html {
        body {
          list {
            forEach(1...3) { counter in
              listItem(label: "item #\(counter)")
            }
          }
          orderedList {
            forEach(1...3) { _ in
              listItem(label: "item")
            }
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
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
        <ol>
          <li>
            item
          </li>
          <li>
            item
          </li>
          <li>
            item
          </li>
        </ol>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithLists())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testDiv() {
    func pageWithDivs() -> HTML {
      html {
        body {
          div {
            "Page body"
            }.class("vaux-class").id("abcdef")
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <div id="abcdef" class="vaux-class">
          Page body
        </div>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithDivs())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testCustomTag() {
    func pageWithCustomTag() -> HTML {
      html {
        body {
          custom(tag: "any-tag") {
            "This is text inside a custom tag"
            }.id("12345")
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <any-tag id="12345">
          This is text inside a custom tag
        </any-tag>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithCustomTag())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testHeading() {
    func pageWithHeading() -> HTML {
      html {
        body {
          heading(.h1) {
            "This is a heading of weight 1"
          }
          heading(.h3) {
            "This is a heading of weight 3"
          }
          paragraph {
            "Four score and seven years ago..."
          }
          }.style([StyleAttribute(key: "background-color", value: "blue"),
                   StyleAttribute(key: "color", value: "red")])
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body style="background-color:blue;color:red">
        <h1>
          This is a heading of weight 1
        </h1>
        <h3>
          This is a heading of weight 3
        </h3>
        <p>
          Four score and seven years ago...
        </p>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithHeading())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testNestedPages() {
    func masterPage() -> HTML {
      html {
        linkStylesheet(url: "/tmp/style.css").type(.css)
        body {
          childPage()
        }
      }
    }
    func childPage() -> HTML {
      div {
        "Some div content"
        }.id("abcd")
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <link type="text/css" rel="stylesheet" href="/tmp/style.css"/>
      <body>
        <div id="abcd">
          Some div content
        </div>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: masterPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testMIME() {
    func masterPage() -> HTML {
      html {
        linkStylesheet(url: "/tmp/style.css").type(.css)
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <link type="text/css" rel="stylesheet" href="/tmp/style.css"/>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: masterPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testCustomMIME() {
    func masterPage() -> HTML {
      html {
        linkStylesheet(url: "/tmp/style.css").type("text/css")
        body {
          childPage()
        }
      }
    }
    func childPage() -> HTML {
      div {
        "Some div content"
      }.id("abcd")
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <link type="text/css" rel="stylesheet" href="/tmp/style.css"/>
      <body>
        <div id="abcd">
          Some div content
        </div>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: masterPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testImage() {
    var url = "my_image.png"
    func pageWithImage() -> HTML {
      html {
        body {
          image(url: url)
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <img src="my_image.png"/>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithImage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testAttributes() {
    func buildPage() -> HTML {
      html {
        body {
          div {
            "Custom tag text goes here"
            }.attr("key", "value")
            .id("my_custom")
            .class("custom class")
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <div class="custom class" id="my_custom" key="value">
          Custom tag text goes here
        </div>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: buildPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testScriptCode() {
    let scriptID = "script"
    func pageWithJavascript() -> HTML {
      html {
        body {
          paragraph { "" }.id(scriptID)
          script(code: "document.getElementById('\(scriptID)').innerHTML = 'Hello JavaScript!';")
        }
      }
    }
    let correctHTML = """
        <!DOCTYPE html>
        <html>
          <body>
            <p id="\(scriptID)">
            </p>
            <script>
              document.getElementById('\(scriptID)').innerHTML = 'Hello JavaScript!';
            </script>
          </body>
        </html>
        """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: pageWithJavascript())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testScriptFile() {
    func buildPage() -> HTML {
      html {
        body {
          script(filepath: Filepath(name: "script.js", path: ""))
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <script src="script.js">
          </script>
        </body>
      </html>
      """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: buildPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  public static func renderForTesting(with vaux: Vaux, html: HTML) throws -> String {
    do {
      try vaux.render(html)
      let rendered = try VauxFileHelper.getRenderedContent(from: Filepath(name: "testing", path: "/tmp/")).replacingOccurrences(of: "\n", with: "")
      return rendered
    } catch let error {
      throw error
    }
  }

  public static func getLocalFileForTesting(named: String) throws -> String {
    do {
      let thisPathArray = #file.split(separator: "/").map {String($0)}.dropLast()
      var newPath = "/"
      for component in thisPathArray { newPath.append(component + "/") }
      return try VauxFileHelper.getRenderedContent(from: Filepath(name: named, path: newPath))
    } catch let error {
      throw error
    }
  }

  static var allTests = [
    ("testSimplePage", testSimplePage),
    ("testLink", testLink),
    ("testLinkInline", testLinkInline),
    ("testLinkWithChild", testLinkWithChild),
    ("testLinebreak", testLinebreak),
    ("testArticle", testArticle),
    ("testEmphasis", testEmphasis),
    ("testTextHighlighting", testTextHighlighting),
    ("testTextStrong", testTextStrong),
    ("testTextCite", testTextCite),
    ("testTextBlockquote", testTextBlockquote),
    ("testTextShortQuote", testTextShortQuote),
    ("testTextCode", testTextCode),
    ("testStdout", testStdout),
    ("testDiv", testDiv),
    ("testCustomTag", testCustomTag),
    ("testLists", testLists),
    ("testHeading", testHeading),
    ("testNestedPages", testNestedPages),
    ("testMIME", testMIME),
    ("testCustomMIME", testCustomMIME),
    ("testImage", testImage),
    ("testAttributes", testAttributes),
    ("testSpan", testSpan),
    ("testScriptCode", testScriptCode),
    ("testScriptFile", testScriptFile)
  ]
}
