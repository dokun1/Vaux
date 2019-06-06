import XCTest
@testable import Vaux

final class VauxTests: XCTestCase {
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
    
    func pageWithManyElements() -> HTML {
        html {
            head {
                title("A page with a bunch of elements")
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
        let vaux = Vaux()
        vaux.output = .stdout
        vaux.render(simplePage())
        XCTAssertEqual(1, 1)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

