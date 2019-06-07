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
            XCTAssertEqual(rendered, correctHTML)
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
                    }.id("david")
                }
            }
        }
        let correctHTML = """
            <html>
              <body>
                <any-tag id="david">
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
                        emphasis {
                            "Four score and seven years ago..."
                        }
                    }
                }.attr("style", "background-color:blue")
            }
        }
        let correctHTML = """
            <html>
              <body style="background-color:blue">
                <h1>
                  This is a heading of weight 1
                </h1>
                <h3>
                  This is a heading of weight 3
                </h3>
                <p>
                  <em>
                    Four score and seven years ago...
                  </em>
                </p>
              </body>
            </html>
            """.replacingOccurrences(of: "\n", with: "")
        let vaux = Vaux()
        vaux.outputLocation = .file(name: "testing", path: "/tmp/")
        do {
            let rendered = try renderForTesting(with: vaux, html: pageWithHeading())
            XCTAssertEqual(rendered, correctHTML)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    private func renderForTesting(with vaux: Vaux, html: HTML) throws -> String {
        do {
            try vaux.render(html)
            let rendered = try VauxFileHelper.getString(from: "testing").replacingOccurrences(of: "\n", with: "")
            return rendered
        } catch let error {
            throw error
        }
    }
    

    static var allTests = [
        ("testSimplePage", testSimplePage),
        ("testLink", testLink),
        ("testDiv", testDiv),
        ("testCustomTag", testCustomTag),
        ("testLists", testLists)
    ]
}
