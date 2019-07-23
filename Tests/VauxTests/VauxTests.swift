//
//  VauxTests.swift
//
//
//  Created by David Okun on 6/6/19.
//
// Many of the HTML examples are taken from w3schools.com.

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
          <span style="color:blue;">
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
  
  func testKeyboard() {
    func pageWithLink() -> HTML {
      html {
        body {
          keyboard {
            "Keyboard input"
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <kbd>
          Keyboard input
        </kbd>
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
  
  func testTextBold() {
    func formattedPage() -> HTML {
      html {
        body {
          paragraph {
            "This is normal text -"
            bold {
              "and this is bold text"
            }
            "."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          This is normal text -
          <b>
            and this is bold text
          </b>
          .
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
  
  func testTextMark() {
    func formattedPage() -> HTML {
      html {
        body {
          paragraph {
            "Do not forget to buy"
            mark {
              "milk"
            }
            "today."
          }
        }
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body>
        <p>
          Do not forget to buy
          <mark>
            milk
          </mark>
          today.
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
      <body style="background-color:blue;color:red;">
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
  
  func testAbbreviation() {
    func buildPage() -> HTML {
      html {
        body {
          "The"
          abbreviation(title: "World Health Organization") { "WHO" }
          "was founded in 1948."
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          The
          <abbr title="World Health Organization">
            WHO
          </abbr>
          was founded in 1948.
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
  
  func testAdress() {
    func buildPage() -> HTML {
    html {
        body {
          address {
            "Written by Jon Doe."
            lineBreak()
            "Visit us at:"
            lineBreak()
            "Example.com"
            lineBreak()
            "Box 564, Disneyland"
            lineBreak()
            "USA"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <address>
            Written by Jon Doe.
            <br/>
            Visit us at:
            <br/>
            Example.com
            <br/>
            Box 564, Disneyland
            <br/>
            USA
          </address>
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
  
  func testArea() {
    func buildPage() -> HTML {
      html {
        body {
          map(name: "planetmap") {
            area(rectangle: (x1: 0, y1: 0, x2: 82, y2: 126), url: "sun.htm")
            area(circle: (x: 90, y: 58, radius: 3), url: "mercur.htm")
            area(shape: .circle, coords: [124, 58, 8], url: "venus.htm")
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <map name="planetmap">
            <area shape="rect" coords="0,0,82,126" href="sun.htm"/>
            <area shape="circle" coords="90,58,3" href="mercur.htm"/>
            <area shape="circle" coords="124,58,8" href="venus.htm"/>
          </map>
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
  
  func testAudio() {
    func buildPage() -> HTML {
      html {
        body {
          audio(sources:[
            (url: "horse.ogg", type: .oga),
            (url: "horse.mp3", type: .mp3)
            ],
                unsupportedLabel: "Your browser does not support the audio element.")
            .attr("controls")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <audio controls>
            <source src="horse.ogg" type="audio/ogg"/>
            <source src="horse.mp3" type="audio/mpeg"/>
            Your browser does not support the audio element.
          </audio>
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
  
  func testBase() {
    func buildPage() -> HTML {
      html {
        head {
          base(url: "https://www.w3schools.com/images/", target: .blank)
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <head>
          <base href="https://www.w3schools.com/images/" target="_blank"/>
        </head>
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
  
  func testDirection() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            directional(direction: .leftToRight) {
              "This paragraph will go left-to-right."
            }
          }
          paragraph {
            directional(direction: .rightToLeft) {
              "This paragraph will go right-to-left."
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            <bdo dir="ltr">
              This paragraph will go left-to-right.
            </bdo>
          </p>
          <p>
            <bdo dir="rtl">
              This paragraph will go right-to-left.
            </bdo>
          </p>
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
  
  func testButton() {
    func buildPage() -> HTML {
      html {
        body {
          button(type: .button) {
            "Click Me!"
            }.attr("onclick", "alert('Hello world!')")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <button onclick="alert('Hello world!')" type="button">
            Click Me!
          </button>
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
  
  func testColumnGroup() {
    func buildPage() -> HTML {
      html {
        body {
          table {
            columnGroup(styles: [
              TableColumnStyle(span: 2, styles: [StyleAttribute(key: "background-color", value: "red")]),
              TableColumnStyle(styles: [StyleAttribute(key: "background-color", value: "yellow")])
              ])
            tableRow {
              tableHeadData {
                "ISBN"
              }
              tableHeadData {
                "Title"
              }
              tableHeadData {
                "Price"
              }
            }
            tableRow {
              tableData {
                3476896
              }
              tableData {
                "My first HTML"
              }
              tableData {
                "$53"
              }
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <table>
            <colgroup>
              <col span="2" style="background-color:red;"/>
              <col style="background-color:yellow;"/>
            </colgroup>
            <tr>
              <th>
                ISBN
              </th>
              <th>
                Title
              </th>
              <th>
                Price
              </th>
            </tr>
            <tr>
              <td>
                3476896
              </td>
              <td>
                My first HTML
              </td>
              <td>
                $53
              </td>
            </tr>
          </table>
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
  
  func testData() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            "The following example displays product names but also associates each name with a product number:"
          }
          list {
            listItem {
              data(value: "21053") {
                "Cherry Tomato"
              }
            }
            listItem {
              data(value: "21054") {
                "Beef Tomato"
              }
            }
            listItem {
              data(value: "21055") {
                "Snack Tomato"
              }
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            The following example displays product names but also associates each name with a product number:
          </p>
          <ul>
            <li>
              <data value="21053">
                Cherry Tomato
              </data>
            </li>
            <li>
              <data value="21054">
                Beef Tomato
              </data>
            </li>
            <li>
              <data value="21055">
                Snack Tomato
              </data>
            </li>
          </ul>
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
  
  func testDataList() {
    func buildPage() -> HTML {
      html {
        body {
          form {
            input().attr("name", "browser").attr("list", "browsers")
            data(list: [
              "Internet Explorer",
              "Firefox",
              "Chrome",
              "Opera",
              "Safari"], id: "browsers")
            input(type: .submit)
            }.attr("method", "get").attr("action", "/action_page.php")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <form action="/action_page.php" method="get">
            <input list="browsers" name="browser"/>
            <datalist id="browsers">
              <option value="Internet Explorer"/>
              <option value="Firefox"/>
              <option value="Chrome"/>
              <option value="Opera"/>
              <option value="Safari"/>
            </datalist>
            <input type="submit"/>
          </form>
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
  
  func testDescriptionList() {
    func buildPage() -> HTML {
      html {
        body {
          descriptionList {
            define {
              "Coffee"
            }
            describe {
              "Black hot drink"
            }
            define {
              "Milk"
            }
            describe {
              "White cold drink"
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <dl>
            <dt>
              Coffee
            </dt>
            <dd>
              Black hot drink
            </dd>
            <dt>
              Milk
            </dt>
            <dd>
              White cold drink
            </dd>
          </dl>
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
  
  func testDeletionReplacement() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            "My favorite color is"
            delete {
              "blue"
            }
            insert {
              "red"
            }
            "!"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            My favorite color is
            <del>
              blue
            </del>
            <ins>
              red
            </ins>
            !
          </p>
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
  
  func testDetails() {
    func buildPage() -> HTML {
      html {
        body {
          details {
            summary {
              "License."
            }
            paragraph {
              "Apache License 2.0"
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <details>
            <summary>
              License.
            </summary>
            <p>
              Apache License 2.0
            </p>
          </details>
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
  
  func testDefining() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            defining {
              abbreviation(title: "HyperText Markup Language") {
                "HTML"
              }
            }
            "is the standard markup language for creating web pages."
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            <dfn>
              <abbr title="HyperText Markup Language">
                HTML
              </abbr>
            </dfn>
            is the standard markup language for creating web pages.
          </p>
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
  
  func testDialog() {
    func buildPage() -> HTML {
      html {
        body {
          dialog(open: true) {
            paragraph {
              "Greetings, one and all!"
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <dialog open>
            <p>
              Greetings, one and all!
            </p>
          </dialog>
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
  
  func testEmbed() {
    func buildPage() -> HTML {
      html {
        body {
          embed(url: "helloworld.swf")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <embed src="helloworld.swf"/>
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
  
  func testFieldset() {
    func buildPage() -> HTML {
      html {
        body {
          form {
            fieldset {
              legend {
                "Personalia:"
              }
              "Name:"
              input(type: .text)
              lineBreak()
              "Email:"
              input(type: .text)
              lineBreak()
              "Date of birth:"
              input(type: .text)
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <form>
            <fieldset>
              <legend>
                Personalia:
              </legend>
              Name:
              <input type="text"/>
              <br/>
              Email:
              <input type="text"/>
              <br/>
              Date of birth:
              <input type="text"/>
            </fieldset>
          </form>
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
  
  func testFigure() {
    func buildPage() -> HTML {
      html {
        body {
          figure(caption: FigureCaption(place: .bottom, caption: "Fig.1 - The image&trade; caption.")) {
            image(url: "image.png")
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <figure>
            <img src="image.png"/>
            <figcaption>
              Fig.1 - The image&trade; caption.
            </figcaption>
          </figure>
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
  
  func testFooter() {
    func buildPage() -> HTML {
      html {
        body {
          footer {
            paragraph {
              "Contact information:"
              link(url: "mailto:someone@example.com") {
                "someone@example.com"
              }
              "."
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <footer>
            <p>
              Contact information:
              <a href="mailto:someone@example.com">
                someone@example.com
              </a>
              .
            </p>
          </footer>
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
  
  func testHeader() {
    func buildPage() -> HTML {
      html {
        body {
          article {
            header {
              heading(.h1) {
                "Most important heading here"
              }
              heading(.h3) {
                "Less important heading here"
              }
              paragraph {
                "Some additional information here."
              }
            }
            paragraph {
              "Lorem Ipsum dolor set amet..."
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <article>
            <header>
              <h1>
                Most important heading here
              </h1>
              <h3>
                Less important heading here
              </h3>
              <p>
                Some additional information here.
              </p>
            </header>
            <p>
              Lorem Ipsum dolor set amet...
            </p>
          </article>
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
  
  func testBreak() {
    func buildPage() -> HTML {
      html {
        body {
          heading(.h1) {
            "HTML"
          }
          paragraph {
            "HTML is a language for describing web pages."
          }
          `break`()
          heading(.h1) {
            "CSS"
          }
          paragraph {
            "CSS defines how to display HTML elements."
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <h1>
            HTML
          </h1>
          <p>
            HTML is a language for describing web pages.
          </p>
          <hr/>
          <h1>
            CSS
          </h1>
          <p>
            CSS defines how to display HTML elements.
          </p>
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
  
  func testIframe() {
    func buildPage() -> HTML {
      html {
        body {
          iframe(url: "https://www.w3schools.com") {
            paragraph {
              "Your browser does not support iframes."
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <iframe src="https://www.w3schools.com">
            <p>
              Your browser does not support iframes.
            </p>
          </iframe>
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
  
  func testLabel() {
    func buildPage() -> HTML {
      html {
        body {
          form {
            label(for: "male") {
              "Male"
            }
            input(type: .radio).attr("value", "male").attr("id", "male").attr("name", "gender")
            lineBreak()
            label(for: "female") {
              "Female"
            }
            input(type: .radio).attr("value", "female").attr("id", "female").attr("name", "gender")
            lineBreak()
            label(for: "other") {
              "Other"
            }
            input(type: .radio).attr("value", "other").attr("id", "other").attr("name", "gender")
            lineBreak()
            input(type: .submit).attr("value", "Submit")
            }.attr("action", "/action_page.php")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <form action="/action_page.php">
            <label for="male">
              Male
            </label>
            <input name="gender" id="male" value="male" type="radio"/>
            <br/>
            <label for="female">
              Female
            </label>
            <input name="gender" id="female" value="female" type="radio"/>
            <br/>
            <label for="other">
              Other
            </label>
            <input name="gender" id="other" value="other" type="radio"/>
            <br/>
            <input value="Submit" type="submit"/>
          </form>
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
  
  func testMain() {
    func buildPage() -> HTML {
      html {
        body {
          main {
            heading(.h1) {
              "Web Browsers"
            }
            paragraph {
              "Google Chrome, Firefox, and Internet Explorer are the most used browsers today."
            }
            article {
              heading(.h1) {
                "Google Chrome"
              }
              paragraph {
                "Google Chrome is a free, open-source web browser developed by Google, released in 2008."
              }
            }
            article {
              heading(.h1) {
                "Internet Explorer"
              }
              paragraph {
                "Internet Explorer is a free web browser from Microsoft, released in 1995."
              }
            }
            article {
              heading(.h1) {
                "Mozilla Firefox"
              }
              paragraph {
                "Firefox is a free, open-source web browser from Mozilla, released in 2004."
              }
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <main>
            <h1>
              Web Browsers
            </h1>
            <p>
              Google Chrome, Firefox, and Internet Explorer are the most used browsers today.
            </p>
            <article>
              <h1>
                Google Chrome
              </h1>
              <p>
                Google Chrome is a free, open-source web browser developed by Google, released in 2008.
              </p>
            </article>
            <article>
              <h1>
                Internet Explorer
              </h1>
              <p>
                Internet Explorer is a free web browser from Microsoft, released in 1995.
              </p>
            </article>
            <article>
              <h1>
                Mozilla Firefox
              </h1>
              <p>
                Firefox is a free, open-source web browser from Mozilla, released in 2004.
              </p>
            </article>
          </main>
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
  
  func testMeta() {
    func buildPage() -> HTML {
      html {
        head {
          meta().attr("charset", "UTF-8")
          meta(type: .name("VauxTest"))
          meta(type: .keywords("HTML, JavaScript"))
          meta(type: .description("HTML DSL in Swift"))
          meta(type: .author("John Doe"))
          meta(type: .viewport("width=device-width, initial-scale=1.0"))
          meta(type: .generator("Vaux"))
          meta(content: "30").attr("http-equiv", "refresh")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="UTF-8"/>
          <meta name="VauxTest"/>
          <meta name="keywords" content="HTML, JavaScript"/>
          <meta name="description" content="HTML DSL in Swift"/>
          <meta name="author" content="John Doe"/>
          <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
          <meta name="generator" content="Vaux"/>
          <meta http-equiv="refresh" content="30"/>
        </head>
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
  
  func testMeter() {
    func buildPage() -> HTML {
      html {
        body {
          meter(value: 2) {
            "2 out of 10"
            }.attr("max", "10").attr("min", "0")
          lineBreak()
          meter(value: 0.6) {
            "60%"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <meter min="0" max="10" value="2">
            2 out of 10
          </meter>
          <br/>
          <meter value="0.6">
            60%
          </meter>
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
  
  func testNavigation() {
    func buildPage() -> HTML {
      html {
        body {
          navigation {
            link(url: "/html/") {
              "HTML"
            }
            "|"
            link(url: "/css/") {
              "CSS"
            }
            "|"
            link(url: "/js/") {
              "JavaScript"
            }
            "|"
            link(url: "/jquery/") {
              "jQuery"
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <nav>
            <a href="/html/">
              HTML
            </a>
            |
            <a href="/css/">
              CSS
            </a>
            |
            <a href="/js/">
              JavaScript
            </a>
            |
            <a href="/jquery/">
              jQuery
            </a>
          </nav>
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
  
  func testNoScript() {
    func buildPage() -> HTML {
      html {
        body {
          script(code: "document.write('Hello World!')")
          noScript {
            "Your browser does not support JavaScript!"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <script>
            document.write('Hello World!')
          </script>
          <noscript>
            Your browser does not support JavaScript!
          </noscript>
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
  
  func testObject() {
    func buildPage() -> HTML {
      html {
        body {
          object{
            ""
            }.attr("data", "helloworld.swf").attr("height", "400").attr("width", "400")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <object width="400" height="400" data="helloworld.swf">
          </object>
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
  
  func testOptionGroup() {
    func buildPage() -> HTML {
      html {
        body {
          select {
            optionGroup {
              option {
                "Volvo"
                }.attr("value", "volvo")
              option {
                "Saab"
                }.attr("value", "saab")
              }.attr("label", "Swedish Cars")
            optionGroup {
              option {
                "Mercedes"
                }.attr("value", "mercedes")
              option {
                "Audi"
                }.attr("value", "audi")
              }.attr("label", "German Cars")
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <select>
            <optgroup label="Swedish Cars">
              <option value="volvo">
                Volvo
              </option>
              <option value="saab">
                Saab
              </option>
            </optgroup>
            <optgroup label="German Cars">
              <option value="mercedes">
                Mercedes
              </option>
              <option value="audi">
                Audi
              </option>
            </optgroup>
          </select>
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
  
  func testOutput() {
    func buildPage() -> HTML {
      html {
        body {
          form {
            "0"
            input(type: .range).attr("value", "50").attr("id", "a")
            "100 +"
            input(type: .number).attr("value", "50").attr("id", "b")
            "="
            output {
              ""
              }.attr("for", "a b").attr("name", "x")
            }.attr("oninput", "x.value=parseInt(a.value)+parseInt(b.value)")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <form oninput="x.value=parseInt(a.value)+parseInt(b.value)">
            0
            <input id="a" value="50" type="range"/>
            100 +
            <input id="b" value="50" type="number"/>
            =
            <output name="x" for="a b">
            </output>
          </form>
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
  
  func testParameter() {
    func buildPage() -> HTML {
      html {
        body {
          object{
            parameter(name: "autoplay", value: "true")
            }.attr("data", "horse.wav")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <object data="horse.wav">
            <param name="autoplay" value="true"/>
          </object>
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
  
  func testPicture() {
    func buildPage() -> HTML {
      html {
        body {
          picture {
            source(pictureURL: "img_pink_flowers.jpg").attr("media", "(min-width: 650px)")
            source(pictureURL: "img_white_flower.jpg").attr("media", "(min-width: 465px)")
            image(url: "img_orange_flowers.jpg")
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <picture>
            <source media="(min-width: 650px)" srcset="img_pink_flowers.jpg"/>
            <source media="(min-width: 465px)" srcset="img_white_flower.jpg"/>
            <img src="img_orange_flowers.jpg"/>
          </picture>
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
  
  func testPreformatted() {
    func buildPage() -> HTML {
      html {
        body {
          preformatted {
            """
            Text in a pre element
            is displayed in a fixed-width
            font, and it preserves
            both      spaces and
            line breaks
            """
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <pre>
            Text in a pre element
            is displayed in a fixed-width
            font, and it preserves
            both      spaces and
            line breaks
          </pre>
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
  
  func testProgress() {
    func buildPage() -> HTML {
      html {
        body {
          progress {
            ""
            }.attr("max", "100").attr("value", "22")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <progress value="22" max="100">
          </progress>
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
  
  func testRuby() {
    func buildPage() -> HTML {
      html {
        body {
          ruby {
            "漢"
            rubyPronunciation {
              rubyParenthesis {
                "("
              }
              "ㄏㄢˋ"
              rubyParenthesis {
                ")"
              }
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <ruby>
            漢
            <rt>
              <rp>
                (
              </rp>
              ㄏㄢˋ
              <rp>
                )
              </rp>
            </rt>
          </ruby>
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
  
  func testSample() {
    func buildPage() -> HTML {
      html {
        body {
          sample {
            "Sample output from a computer program"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <samp>
            Sample output from a computer program
          </samp>
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
  
  func testSection() {
    func buildPage() -> HTML {
      html {
        body {
          section {
            heading(.h1) {
              "WWF"
            }
            paragraph {
              "The World Wide Fund for Nature (WWF) is..."
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <section>
            <h1>
              WWF
            </h1>
            <p>
              The World Wide Fund for Nature (WWF) is...
            </p>
          </section>
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
  
  func testSmall() {
    func buildPage() -> HTML {
      html {
        body {
          small {
            "Apache License 2.0"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <small>
            Apache License 2.0
          </small>
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
  
  func testStyle() {
    func buildPage() -> HTML {
      html {
        head {
          style(code:
            """
            h1 {color:red;}
            p {color:blue;}
            """
          )
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <head>
          <style>
            h1 {color:red;}
            p {color:blue;}
          </style>
        </head>
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
  
  func testSubscriptSupscript() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            "This text contains"
            `subscript` {
              "subscript"
            }
            "text and"
            superscript {
              "superscript"
            }
            "text."
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            This text contains
            <sub>
              subscript
            </sub>
            text and
            <sup>
              superscript
            </sup>
            text.
          </p>
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
  
  func testTemplate() {
    func buildPage() -> HTML {
      html {
        body {
          template {
            heading(.h2) {
              "Flower"
            }
            image(url: "img_white_flower.jpg")
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <template>
            <h2>
              Flower
            </h2>
            <img src="img_white_flower.jpg"/>
          </template>
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
  
  func testTextArea() {
    func buildPage() -> HTML {
      html {
        body {
          textarea {
            "At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies."
            }.attr("cols","50").attr("rows","4")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <textarea rows="4" cols="50">
            At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies.
          </textarea>
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
  
  func testTable() {
    func buildPage() -> HTML {
      html {
        body {
          table {
            tableHead {
              tableRow {
                tableHeadData {
                  "Month"
                }
                tableHeadData {
                  "Savings"
                }
              }
            }
            tableBody {
              tableRow {
                tableData {
                  "January"
                }
                tableData {
                  "$100"
                }
              }
              tableRow {
                tableData {
                  "February"
                }
                tableData {
                  "$80"
                }
              }
            }
            tableFoot {
              tableRow {
                tableData {
                  "Sum"
                }
                tableData {
                  "$180"
                }
              }
            }
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <table>
            <thead>
              <tr>
                <th>
                  Month
                </th>
                <th>
                  Savings
                </th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  January
                </td>
                <td>
                  $100
                </td>
              </tr>
              <tr>
                <td>
                  February
                </td>
                <td>
                  $80
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td>
                  Sum
                </td>
                <td>
                  $180
                </td>
              </tr>
            </tfoot>
          </table>
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
  
  func testTime() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            "We open at"
            time {
              "10:00"
            }
            "every morning."
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            We open at
            <time>
              10:00
            </time>
            every morning.
          </p>
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
  
  func testTrack() {
    func buildPage() -> HTML {
      html {
        body {
          video {
            source(mediaURL: "forrest_gump.mp4").type(.mp4)
            source(mediaURL: "forrest_gump.ogg").type(.ogv)
            track(url: "subtitles_en.vtt").attr("label", "English").attr("srclang", "en").attr("kind", "subtitles")
            track(url: "subtitles_no.vtt").attr("label", "Norwegian").attr("srclang", "no").attr("kind", "subtitles")
            }.attr("controls").attr("height", "240").attr("width","320")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <video width="320" height="240" controls>
            <source type="video/mp4" src="forrest_gump.mp4"/>
            <source type="video/ogg" src="forrest_gump.ogg"/>
            <track kind="subtitles" srclang="en" label="English" src="subtitles_en.vtt"/>
            <track kind="subtitles" srclang="no" label="Norwegian" src="subtitles_no.vtt"/>
          </video>
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
  
  func testUnderline() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            "This is a"
            underline {
              "parragraph"
            }
            "."
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            This is a
            <u>
              parragraph
            </u>
            .
          </p>
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
  
  func testVariable() {
    func buildPage() -> HTML {
      html {
        body {
          variable {
            "Variable"
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <var>
            Variable
          </var>
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
  
  func testWordBreak() {
    func buildPage() -> HTML {
      html {
        body {
          paragraph {
            "To learn AJAX, you must be familiar with the XML"
            wordBreak()
            "Http"
            wordBreak()
            "Request Object."
          }
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <p>
            To learn AJAX, you must be familiar with the XML
            <wbr/>
            Http
            <wbr/>
            Request Object.
          </p>
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
  
  func testStyles() {
    func pageWithHeading() -> HTML {
      html {
        body {
          heading(.h1) {
            "This is a heading"
          }.style([StyleAttribute(key: "color", value: "blue"),
                   StyleAttribute(key: "font-family", value: "verdana")])
          paragraph {
            "This is a paragraph."
          }.style([StyleAttribute(key: "font-family", value: "courier"),
                   StyleAttribute(key: "font-size", value: "160%"),
                   StyleAttribute(key: "color", value: "blue")])
          }.style([StyleAttribute(key: "background-color", value: "powderblue")])
      }
    }
    let correctHTML = """
    <!DOCTYPE html>
    <html>
      <body style="background-color:powderblue;">
        <h1 style="color:blue;font-family:verdana;">
          This is a heading
        </h1>
        <p style="font-family:courier;font-size:160%;color:blue;">
          This is a paragraph.
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
  
  func testSVGCustom() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            customSVG(tag: "circle")
              .attr("fill", "yellow")
              .attr("stroke-width","4")
              .attr("stroke","green")
              .attr("r","40")
              .attr("cy","50")
              .attr("cx","50")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow"/>
          </svg>
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
  
  func testSVGCircle() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            circle(radius: 40)
              .attr("fill", "yellow")
              .attr("stroke-width","4")
              .attr("stroke","green")
              .attr("cy","50")
              .attr("cx","50")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <circle cx="50" cy="50" stroke="green" stroke-width="4" fill="yellow" r="40"/>
          </svg>
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
  
  func testSVGRectangle() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            rectangle(width: 300, height: 100)
              .style(
                [
                  StyleAttribute(key: "fill", value: "rgb(0,0,255)"),
                  StyleAttribute(key: "stroke-width", value:"3"),
                  StyleAttribute(key: "stroke", value: "rgb(0,0,0)")
                ])
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <rect style="fill:rgb(0,0,255);stroke-width:3;stroke:rgb(0,0,0)" width="300" height="100"/>
          </svg>
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
  
  func testSVGEllipse() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            ellipse(horizontalRadius: 100, verticalRadius: 50)
              .style(
                [
                  StyleAttribute(key: "fill", value: "yellow"),
                  StyleAttribute(key: "stroke", value: "purple"),
                  StyleAttribute(key: "stroke-width", value:"2")
                ])
              .position(centerX: 200, centerY: 80)
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <ellipse cx="200" cy="80" style="fill:yellow;stroke:purple;stroke-width:2" rx="100" ry="50"/>
          </svg>
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
  
  func testSVGLine() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            line(startX: 0, startY: 0, endX: 200, endY: 200)
              .style(
                [
                  StyleAttribute(key: "stroke", value: "rgb(255,0,0)"),
                  StyleAttribute(key: "stroke-width", value:"2")
                ])
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <line style="stroke:rgb(255,0,0);stroke-width:2" x1="0" y1="0" x2="200" y2="200"/>
          </svg>
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
  
  func testSVGPolygon() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            polygon(points:
              [
                (x: 200, y: 10),
                (x: 250, y: 190),
                (x: 160, y: 210)
              ])
              .style(
                [
                  StyleAttribute(key: "fill", value: "lime"),
                  StyleAttribute(key: "stroke", value: "purple"),
                  StyleAttribute(key: "stroke-width", value:"1")
                ])
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <polygon style="fill:lime;stroke:purple;stroke-width:1" points="200,10 250,190 160,210"/>
          </svg>
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
  
  func testSVGPolyline() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            polyline(points:
              [
                (x: 20, y: 20),
                (x: 40, y: 25),
                (x: 60, y: 40),
                (x: 80, y: 120),
                (x: 120, y: 140),
                (x: 200, y: 180)
              ])
              .style(
                [
                  StyleAttribute(key: "fill", value: "none"),
                  StyleAttribute(key: "stroke", value: "black"),
                  StyleAttribute(key: "stroke-width", value:"3")
                ])
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <polyline style="fill:none;stroke:black;stroke-width:3" points="20,20 40,25 60,40 80,120 120,140 200,180"/>
          </svg>
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
  
  func testSVGPath() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            path(points: [
              .moveto(150, 0, true),
              .lineto(75, 200, true),
              .lineto(225, 200, true),
              .closePath
              ])
            path(points: [
              .moveto(175, 200, true),
              .lineto(150, 0, false),
              ])
              .attr("fill", "none")
              .attr("stroke-width", "3")
              .attr("stroke", "green")
            path(points: [
              .moveto(100, 350, true),
              .quadraticBézierCurve(150, -300, 300, false),
              .stop
              ])
              .attr("stroke", "blue")
              .attr("fill", "none")
              .attr("stroke-width", "5")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <path d="M150 0 L75 200 L225 200 Z"/>
            <path stroke="green" stroke-width="3" fill="none" d="M175 200 l150 0"/>
            <path stroke-width="5" fill="none" stroke="blue" d="M100 350 q150 -300 300 0"/>
          </svg>
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
  
  func testSVGText() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            text("I love SVG!")
              .attr("fill", "red")
              .attr("y", "15")
              .attr("x", "0")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <text x="0" y="15" fill="red">
              I love SVG!
            </text>
          </svg>
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
  
  func testSVGGroup() {
    func buildPage() -> HTML {
      html {
        body {
          svg {
            group {
              path(points: [
                .moveto(5, 20, true),
                .lineto(215, 0, false)
              ]).attr("stroke", "red")
              path(points: [
                .moveto(5, 40, true),
                .lineto(215, 0, false)
                ]).attr("stroke", "black")
              path(points: [
                .moveto(5, 60, true),
                .lineto(215, 0, false)
                ]).attr("stroke", "blue")
              }.attr("fill", "none")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <g fill="none">
              <path stroke="red" d="M5 20 l215 0"/>
              <path stroke="black" d="M5 40 l215 0"/>
              <path stroke="blue" d="M5 60 l215 0"/>
            </g>
          </svg>
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
  
  func testSVGFilters() {
    let filters: [SVGFilter] = [
      SVGFilter(
        id: "f1",
        types: [
          .gaussianBlur([
            Attribute(key: "stdDeviation", value: "15"),
            Attribute(key: "in", value: "SourceGraphic"),
            ])
        ],
        attributes: [
          Attribute(key: "x", value: "0"),
          Attribute(key: "y", value: "0"),
        ]
      )
    ]
    func buildPage() -> HTML {
      html {
        body {
          svg {
            definitions(filters: filters)
            rectangle(width: 90, height: 90)
              .attr("filter", "url(#f1)")
              .attr("fill", "yellow")
              .attr("stroke-width", "3")
              .attr("stroke", "green")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <defs>
              <filter id="f1" x="0" y="0">
                <feGaussianBlur in="SourceGraphic" stdDeviation="15"/>
              </filter>
            </defs>
            <rect stroke="green" stroke-width="3" fill="yellow" filter="url(#f1)" width="90" height="90"/>
          </svg>
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
  
  func testSVGMultipleFilters() {
    let filters: [SVGFilter] = [
      SVGFilter(
        id: "f1",
        types: [
          .offset([
            Attribute(key: "dy", value: "20"),
            Attribute(key: "dx", value: "20"),
            Attribute(key: "in", value: "SourceGraphic"),
            Attribute(key: "result", value: "offOut"),
            ]),
          .blend([
            Attribute(key: "mode", value: "normal"),
            Attribute(key: "in2", value: "offOut"),
            Attribute(key: "in", value: "SourceGraphic"),
            ])
        ],
        attributes: [
          Attribute(key: "x", value: "0"),
          Attribute(key: "y", value: "0"),
          Attribute(key: "width", value: "200%"),
          Attribute(key: "height", value: "200%"),
        ]
      )
    ]
    func buildPage() -> HTML {
      html {
        body {
          svg {
            definitions(filters: filters)
            rectangle(width: 90, height: 90)
              .attr("filter", "url(#f1)")
              .attr("fill", "yellow")
              .attr("stroke-width", "3")
              .attr("stroke", "green")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <defs>
              <filter id="f1" x="0" y="0" width="200%" height="200%">
                <feOffset result="offOut" in="SourceGraphic" dx="20" dy="20"/>
                <feBlend in="SourceGraphic" in2="offOut" mode="normal"/>
              </filter>
            </defs>
            <rect stroke="green" stroke-width="3" fill="yellow" filter="url(#f1)" width="90" height="90"/>
          </svg>
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
  
  func testSVGLinearGradient() {
    let linear = SVGGradient(id: "grad1",
                               controls: (x1: "0%", y1: "0%", x2: "100%", y2: "0%"),
                               offsets: [
                                (offset: "0%",
                                 style: [
                                  StyleAttribute(key: "stop-color", value: "rgb(255,255,0)"),
                                  StyleAttribute(key: "stop-opacity", value: "1")
                                  ]
                                ),
                                (offset: "100%",
                                 style: [
                                  StyleAttribute(key: "stop-color", value: "rgb(255,0,0)"),
                                  StyleAttribute(key: "stop-opacity", value: "1")
                                  ]
                                )
                              ]
                            )
    func buildPage() -> HTML {
      html {
        body {
          svg {
            definitions(gradient: linear)
            ellipse(horizontalRadius: 85, verticalRadius: 55)
              .position(centerX: 200, centerY: 70)
              .attr("fill", "url(#grad1)")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <defs>
              <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop style="stop-color:rgb(255,255,0);stop-opacity:1" offset="0%"/>
                <stop style="stop-color:rgb(255,0,0);stop-opacity:1" offset="100%"/>
              </linearGradient>
            </defs>
            <ellipse fill="url(#grad1)" cx="200" cy="70" rx="85" ry="55"/>
          </svg>
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
  
  func testSVGRadialGradient() {
    let linear = SVGGradient(id: "grad1",
                             controls: (cx: "50%", cy: "50%", r: "50%", fx: "50%", fy: "50%"),
                             offsets: [
                              (offset: "0%",
                               style: [
                                StyleAttribute(key: "stop-color", value: "rgb(255,255,255)"),
                                StyleAttribute(key: "stop-opacity", value: "0")
                                ]
                              ),
                              (offset: "100%",
                               style: [
                                StyleAttribute(key: "stop-color", value: "rgb(0,0,255)"),
                                StyleAttribute(key: "stop-opacity", value: "1")
                                ]
                              )
      ]
    )
    func buildPage() -> HTML {
      html {
        body {
          svg {
            definitions(gradient: linear)
            ellipse(horizontalRadius: 85, verticalRadius: 55)
              .position(centerX: 200, centerY: 70)
              .attr("fill", "url(#grad1)")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <defs>
              <radialGradient id="grad1" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">
                <stop style="stop-color:rgb(255,255,255);stop-opacity:0" offset="0%"/>
                <stop style="stop-color:rgb(0,0,255);stop-opacity:1" offset="100%"/>
              </radialGradient>
            </defs>
            <ellipse fill="url(#grad1)" cx="200" cy="70" rx="85" ry="55"/>
          </svg>
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
  
  func testSVGLinearGradientManual() {
    let linear = SVGGradient(id: "grad1",
                             type: .linear,
                             offsets: [
                              (offset: "0%",
                               style: [
                                StyleAttribute(key: "stop-color", value: "rgb(255,255,0)"),
                                StyleAttribute(key: "stop-opacity", value: "1")
                                ]
                              ),
                              (offset: "100%",
                               style: [
                                StyleAttribute(key: "stop-color", value: "rgb(255,0,0)"),
                                StyleAttribute(key: "stop-opacity", value: "1")
                                ]
                              )
      ],
                             attributes: [
                              Attribute(key: "x1", value: "0%"),
                              Attribute(key: "y1", value: "0%"),
                              Attribute(key: "x2", value: "100%"),
                              Attribute(key: "y2", value: "0%")
      ]
    )
    func buildPage() -> HTML {
      html {
        body {
          svg {
            definitions(gradient: linear)
            ellipse(horizontalRadius: 85, verticalRadius: 55)
              .position(centerX: 200, centerY: 70)
              .attr("fill", "url(#grad1)")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <defs>
              <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop style="stop-color:rgb(255,255,0);stop-opacity:1" offset="0%"/>
                <stop style="stop-color:rgb(255,0,0);stop-opacity:1" offset="100%"/>
              </linearGradient>
            </defs>
            <ellipse fill="url(#grad1)" cx="200" cy="70" rx="85" ry="55"/>
          </svg>
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
  
  func testSVGRadialGradientManual() {
    let linear = SVGGradient(id: "grad1",
                             type: .radial,
                             offsets: [
                              (offset: "0%",
                               style: [
                                StyleAttribute(key: "stop-color", value: "rgb(255,255,255)"),
                                StyleAttribute(key: "stop-opacity", value: "0")
                                ]
                              ),
                              (offset: "100%",
                               style: [
                                StyleAttribute(key: "stop-color", value: "rgb(0,0,255)"),
                                StyleAttribute(key: "stop-opacity", value: "1")
                                ]
                              )
      ],
                             attributes: [
                              Attribute(key: "cx", value: "50%"),
                              Attribute(key: "cy", value: "50%"),
                              Attribute(key: "r",  value: "50%"),
                              Attribute(key: "fx", value: "50%"),
                              Attribute(key: "fy", value: "50%")
      ]
    )
    func buildPage() -> HTML {
      html {
        body {
          svg {
            definitions(gradient: linear)
            ellipse(horizontalRadius: 85, verticalRadius: 55)
              .position(centerX: 200, centerY: 70)
              .attr("fill", "url(#grad1)")
            }.attr("height","100").attr("width","100")
        }
      }
    }
    let correctHTML = """
      <!DOCTYPE html>
      <html>
        <body>
          <svg width="100" height="100">
            <defs>
              <radialGradient id="grad1" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">
                <stop style="stop-color:rgb(255,255,255);stop-opacity:0" offset="0%"/>
                <stop style="stop-color:rgb(0,0,255);stop-opacity:1" offset="100%"/>
              </radialGradient>
            </defs>
            <ellipse fill="url(#grad1)" cx="200" cy="70" rx="85" ry="55"/>
          </svg>
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
    ("testKeyboard", testKeyboard),
    ("testTextHighlighting", testTextHighlighting),
    ("testTextStrong", testTextStrong),
    ("testTextBold", testTextBold),
    ("testTextMark", testTextMark),
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
    ("testScriptFile", testScriptFile),
    ("testAbbreviation", testAbbreviation),
    ("testAdress", testAdress),
    ("testAudio", testAudio),
    ("testBase", testBase),
    ("testDirection", testDirection),
    ("testButton", testButton),
    ("testColumnGroup", testColumnGroup),
    ("testData", testData),
    ("testDataList", testDataList),
    ("testDescriptionList", testDescriptionList),
    ("testDeletionReplacement", testDeletionReplacement),
    ("testDetails", testDetails),
    ("testDefining", testDefining),
    ("testDialog", testDialog),
    ("testEmbed", testEmbed),
    ("testFieldset", testFieldset),
    ("testFigure", testFigure),
    ("testFooter", testFooter),
    ("testHeader", testHeader),
    ("testBreak", testBreak),
    ("testIframe", testIframe),
    ("testLabel", testLabel),
    ("testMain", testMain),
    ("testMeta", testMeta),
    ("testMeter", testMeter),
    ("testNoScript", testNoScript),
    ("testObject", testObject),
    ("testOptionGroup", testOptionGroup),
    ("testOutput", testOutput),
    ("testParameter", testParameter),
    ("testPicture", testPicture),
    ("testPreformatted", testPreformatted),
    ("testProgress", testProgress),
    ("testRuby", testRuby),
    ("testSample", testSample),
    ("testSection", testSection),
    ("testSmall", testSmall),
    ("testStyle", testStyle),
    ("testSubscript", testSubscriptSupscript),
    ("testTemplate", testTemplate),
    ("testTextArea", testTextArea),
    ("testTable", testTable),
    ("testTime", testTime),
    ("testTrack", testTrack),
    ("testUnderline", testUnderline),
    ("testVariable", testVariable),
    ("testWordBreak", testWordBreak),
    ("testStyles", testStyles),
    ("testSVGCustom", testSVGCustom),
    ("testSVGCircle", testSVGCircle),
    ("testSVGRectangle", testSVGRectangle),
    ("testSVGEllipse", testSVGEllipse),
    ("testSVGLine", testSVGLine),
    ("testSVGPolygon", testSVGPolygon),
    ("testSVGPolyline", testSVGPolyline),
    ("testSVGPath", testSVGPath),
    ("testSVGText", testSVGText),
    ("testSVGGroup", testSVGGroup),
    ("testSVGFilters", testSVGFilters),
    ("testSVGMultipleFilters", testSVGMultipleFilters),
    ("testSVGLinearGradient", testSVGLinearGradient),
    ("testSVGRadialGradient", testSVGRadialGradient),
    ("testSVGLinearGradientManual", testSVGLinearGradientManual),
  ]
}
