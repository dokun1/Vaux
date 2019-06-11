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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: simplePage())
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: pageWithLink())
      // TODO: Make this pass with better string comparisons
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
    
  func testLinebreak() {
    var url = "https://google.com"
    func pageWithLink() -> HTML {
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
        let rendered = try renderForTesting(with: vaux, html: pageWithLink())
        // TODO: Make this pass with better string comparisons
        XCTAssertEqual(rendered, correctHTML)
    } catch let error {
        XCTFail(error.localizedDescription)
    }
  }
    
  func testEmphasis() {
    var url = "https://google.com"
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
        let rendered = try renderForTesting(with: vaux, html: pageWithLink())
        // TODO: Make this pass with better string comparisons
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
            forEach(1...3) { counter in
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: pageWithLists())
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: pageWithDivs())
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: pageWithCustomTag())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testHeading() {
    func pageWithHeading() -> HTML {
      html {
        body {
          heading(weight: 1) {
            "This is a heading of weight 1"
          }
          heading(weight: 3) {
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
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: pageWithHeading())
      // TODO: make this test pass with better string comparisons
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
  
  func testNestedPages() {
    func masterPage() -> HTML {
      html {
        linkStylesheet(url: "/tmp/style.css")
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
              <link rel="stylesheet" href="/tmp/style.css"/>
              <body>
                <div id="abcd">
                  Some div content
                </div>
              </body>
            </html>
            """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: masterPage())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }
    
  func testAttributes() {
    func buildPage() -> HTML {
        html {
            div {
                "Custom tag text goes here"
                }.attr("key", "value")
        }
    }
    let correctHTML = """
        <!DOCTYPE html>
        <html>
          <div key="value">
            Custom tag text goes here
          </div>
        </html>
        """.replacingOccurrences(of: "\n", with: "")
    let vaux = Vaux()
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
        let rendered = try renderForTesting(with: vaux, html: buildPage())
        XCTAssertEqual(rendered, correctHTML)
    } catch let error {
        XCTFail(error.localizedDescription)
    }
  }
  
  private func renderForTesting(with vaux: Vaux, html: HTML) throws -> String {
    do {
      try vaux.render(html)
      let rendered = try VauxFileHelper.getRenderedContent(from: "testing").replacingOccurrences(of: "\n", with: "")
      return rendered
    } catch let error {
      throw error
    }
  }
  
  
  static var allTests = [
    ("testSimplePage", testSimplePage),
    ("testLink", testLink),
    ("testLinebreak", testLinebreak),
    ("testEmphasis", testEmphasis),
    ("testDiv", testDiv),
    ("testCustomTag", testCustomTag),
    ("testLists", testLists),
    ("testHeading", testHeading),
    ("testNestedPages", testNestedPages),
    ("testAttributes", testAttributes),
  ]
}

