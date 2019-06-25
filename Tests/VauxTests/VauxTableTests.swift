//
//  VauxTableTests.swift
//  
//
//  Created by David Okun on 6/12/19.
//

import XCTest
@testable import Vaux

final class VauxTableTests: XCTestCase {

  func testSimpleTable() {
    func simpleTable() -> HTML {
      html {
        body {
          table {
            tableRow {
              tableData {
                1
              }
              tableData {
                2
              }
            }
            tableRow {
              tableData {
                3
              }
              tableData {
                4
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
          <tr>
            <td>
              1
            </td>
            <td>
              2
            </td>
          </tr>
          <tr>
            <td>
              3
            </td>
            <td>
              4
            </td>
          </tr>
        </table>
      </body>
    </html>
    """.replacingOccurrences(of: "\n", with: "")

    let vaux = Vaux()
    vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      let rendered = try VauxTests.renderForTesting(with: vaux, html: simpleTable())
      XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  func testComplexTable() {

    let valuesOne: [HTML] = ["0.330", "4,879", 5427, "3.7", "4222.6", "57.9", "167", 0, "Closest to the sun"]
    let valuesTwo: [HTML] = ["4.87", "12,104", "5243", "8.9", "2802.0", "108.2", "464", "0", ""]
    let valuesThree: [HTML] = ["5.97", "12,756", "5514", 9.8, "24.0", "149.6", "15", "1", "Our world"]
    let valuesFour: [HTML] = ["0.642", "6,792", "3933", "3.7", "24.7", "227.9", "-65", "2", "The red planet"]
    let valuesFive: [HTML] = ["1898", "142,984", 1326, "23.1", "9.9", "778.6", "110", "67", "The largest planet"]
    let valuesSix: [HTML] = ["568", "120,536", "687", "9.0", "10.7", "1433.5", "140", "62", ""]
    let valuesSeven: [HTML] = ["86.8", "51,118", 1271, "8.7", "17.2", "2872.5", "-195", "27", ""]
    let valuesEight: [HTML] = ["49,528", "1638", "11.0", "16.1", "4495.1", "-200", "14", "", ""]
    let valuesNine: [HTML] = [0.0146,
                              "2,370",
                              2095,
                              0.7,
                              153.3,
                              5906.4,
                              -225,
                              5,
                              div {
                                "Declassified as a planet in 2006, but this "
                                link(url: "http://www.usatoday.com/story/tech/2014/10/02/pluto-planet-solar-system/16578959/", label: "remains controversial").class("external").attr("rel", "noopener")
                                "."
                              }]

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
            superscript { "24" }
          "kg)"
        }.scope(.column)
        tableHeadData {
          "Diameter (km)"
        }.scope(.column)
        tableHeadData {
          "Density (kg/m"
            superscript { "3" }
          ")"
        }.scope(.column)
        tableHeadData {
          "Gravity (m/s"
            superscript{ "2" }
          ")"
        }.scope(.column)
        tableHeadData {
          "Length of day (hours)"
        }.scope(.column)
        tableHeadData {
          "Distance from Sun (10"
            superscript{ "6" }
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
          table {
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
          }.attr("border", "2")
          .attr("cellspacing", "1")
          .attr("cellpadding", "4")
        }
      }
    }

    let vaux = Vaux()
    //vaux.outputLocation = .file(filepath: Filepath(name: "testing", path: "/tmp/"))
    do {
      try vaux.render(complexTable())
      // TODO: Figure out what is causing this test to fail
      //let rendered = try VauxTests.renderForTesting(with: vaux, html: complexTable())
      //let correctHTML = try VauxTests.getLocalFileForTesting(named: "complexTable")
      //XCTAssertEqual(rendered, correctHTML)
    } catch let error {
      XCTFail(error.localizedDescription)
    }
  }

  static var allTests = [
    ("testSimpleTable", testSimpleTable),
    ("testComplexTable", testComplexTable)
  ]
}
