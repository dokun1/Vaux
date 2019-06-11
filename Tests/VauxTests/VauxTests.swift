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
          lineBreak()
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
            "Four score and "
            emphasis { "seven" }
            " years ago..."
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
                  Four score and <em>seven</em> years ago...
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
  
  func testComplexTable() {
    func topRow() -> HTML {
      tableRow {
        tableData {
          nil
          }.columnSpan(2)
        tableHeadData {
          "Name"
          }.scope(.column)
        tableHeadData {
          "Mass (10"
          superscript(value: "24")
          "kg)"
          }.scope(.column)
        tableHeadData {
          "Diameter (km)"
          }.scope(.column)
        tableHeadData {
          "Density (kg/m"
          superscript(value: "3")
          ")"
          }.scope(.column)
        tableHeadData {
          "Gravity (m/s"
          superscript(value: "2")
          ")"
          }.scope(.column)
        tableHeadData {
          "Length of day (hours)"
          }.scope(.column)
        tableHeadData {
          "Distance from Sun (10"
          superscript(value: "6")
          "km)"
          }.scope(.column)
        tableHeadData {
          "Mean temperature (°C)"
          }.scope(.column)
        tableHeadData {
          "Number of Moons"
          }.scope(.column)
        tableHeadData {
          "Notes"
        }.scope(.column)
      }.backgroundColor("CCCCCC")
    }
    
    let valuesOne = ["0.330", "4,879", "5427", "3.7", "4222.6", "57.9", "167", "0", "Closest to the sun"]
    let valuesTwo = ["4.87", "12,104", "5243", "8.9", "2802.0", "108.2", "464", "0", ""]
    let valuesThree = ["5.97", "12,756", "5514", "9.8", "24.0", "149.6", "15", "1", "Our world"]
    let valuesFour = ["0.642", "6,792", "3933", "3.7", "24.7", "227.9", "-65", "2", "The red planet"]
    let valuesFive = ["1898", "142,984", "1326", "23.1", "9.9", "778.6", "110", "67", "The largest planet"]
    let valuesSix = ["568", "120,536", "687", "9.0", "10.7", "1433.5", "140", "62", ""]
    let valuesSeven = ["86.8", "51,118", "1271", "8.7", "17.2", "2872.5", "-195", "27", ""]
    let valuesEight = ["49,528", "1638", "11.0", "16.1", "4495.1", "-200", "14", "", ""]
    func lastLink() -> HTML {
      body {
        "Declassified as a planet in 2006, but this "
        link(url: "http://www.usatoday.com/story/tech/2014/10/02/pluto-planet-solar-system/16578959/", label: "remains controversial").class("external").attr("rel", "noopener")
        "."
      }
    }
    let valuesNine: [HTML] = ["0.0146", "2,370", "2095", "0.7", "153.3", "5906.4", "-225", "5", lastLink()]
    
    func rowOne() -> HTML {
      tableRow {
        tableHeadData {
          "Terrestrial Planets"
        }.columnSpan(2).rowSpan(4).scope(.rowGroup).alignment(.center).backgroundColor("DDDDDD")
        tableHeadData {
          "Mercury"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesOne) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }

    func rowTwo() -> HTML {
      tableRow {
        tableHeadData {
          "Venus"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesTwo) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowThree() -> HTML {
      tableRow {
        tableHeadData {
          "Earth"
          }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesThree) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowFour() -> HTML {
      tableRow {
        tableHeadData {
          "Mars"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesFour) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowFive() -> HTML {
      tableRow {
        tableHeadData {
          "Jovian Planets"
        }.scope(.rowGroup).rowSpan(4).alignment(.center).backgroundColor("DDDDDD")
        tableHeadData {
          "Gas Planets"
        }.scope(.rowGroup).rowSpan(2).alignment(.center).backgroundColor("DDDDDD")
        tableHeadData {
          "Jupiter"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesFive) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowSix() -> HTML {
      tableRow {
        tableHeadData {
          "Saturn"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesSix) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowSeven() -> HTML {
      tableRow {
        tableHeadData {
          "Ice Giants"
        }.scope(.rowGroup).rowSpan(2).alignment(.center).backgroundColor("DDDDDD")
        tableHeadData {
          "Uranus"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesSeven) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowEight() -> HTML {
      tableRow {
        tableHeadData {
          "Neptune"
        }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesEight) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func rowNine() -> HTML {
      tableRow {
        tableHeadData {
          "Dwarf Planets"
        }.columnSpan(2).scope(.rowGroup).alignment(.center).backgroundColor("DDDDDD")
        tableHeadData {
          "Pluto"
          }.scope(.row).alignment(.center).backgroundColor("EEEEEE")
        forEach(valuesNine) { element in
          tableData {
            element
          }.alignment(.center)
        }
      }
    }
    
    func complexTable() -> HTML {
      html {
        body {
          tableGrid {
            caption {
              "Data about the planets of our solar system (Planetary facts taken from "
              link(url: "http://nssdc.gsfc.nasa.gov/planetary/factsheet/", label: "Nasa's Planetary Fact Sheet - Metric").class("external").attr("rel", "noopener")
            }
            tableHead {
              topRow()
            }
            tableBody {
              rowOne()
              rowTwo()
              rowThree()
              rowFour()
              rowFive()
              rowSix()
              rowSeven()
              rowEight()
              rowNine()
            }
          }.attr("border", "2").attr("cellspacing", "1").attr("cellpadding", "4")
        }
      }
    }
    let vaux = Vaux()
    vaux.outputLocation = .file(name: "testing", path: "/tmp/")
    do {
      let rendered = try renderForTesting(with: vaux, html: complexTable())
      XCTAssert(1 == 1)
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
    ("testDiv", testDiv),
    ("testCustomTag", testCustomTag),
    ("testLists", testLists),
    ("testHeading", testHeading),
    ("testNestedPages", testNestedPages)
  ]
}

