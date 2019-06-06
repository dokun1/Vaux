import XCTest
@testable import Vaux

final class VauxTests: XCTestCase {

    var myName = "David Okun"
    
    func pageWithManyElements() -> HTML {
        html {
            head {
                title(myName)
            }
            body {
                forEach(0..<10) { i in
                    div {
                        "This is element number \(i)"
                        
                        br()
                        
                        if i.isMultiple(of: 2) {
                            "It's even!"
                        } else {
                            "It's odd!"
                        }
                        }.class("custom-class")
                }
            }
        }
    }
    
    func testExample() {
        func simplePage() -> HTML {
            html {
                head {
                    title("A simple page!")
                }
                body {
                    div {
                        "This is the page's body"
                    }
                }
            }
        }
        var correctHTML = """
                        <html>
                          <head>
                            <title>
                              A simple page!
                            </title>
                          </head>
                          <body>
                            <div>
                              This is the page's body
                            </div>
                          </body>
                        </html>
"""
        
        let vaux = Vaux()
        vaux.outputLocation = .file(name: "testing")
        try? vaux.render(simplePage())
        guard let rendered = try? VauxFileHelper.getString(from: "testing") else {
            XCTFail()
            return
        }
        XCTAssertEqual(rendered.replacingOccurrences(of: "\n", with: ""), correctHTML.replacingOccurrences(of: "\n", with: ""))
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
                        """
        let vaux = Vaux()
        vaux.outputLocation = .file(name: "testing")
        try? vaux.render(pageWithLink())
        guard let rendered = try? VauxFileHelper.getString(from: "testing") else {
            XCTFail()
            return
        }
        XCTAssertEqual(rendered.replacingOccurrences(of: "\n", with: ""), correctHTML.replacingOccurrences(of: "\n", with: ""))
    }

    static var allTests = [
        ("testExample", testExample), ("testLink", testLink)
    ]
}

