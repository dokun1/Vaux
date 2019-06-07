//
//  FileHelper.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

public class VauxFileHelper {
  /// Allows you to create a `.html` file with a given name and given path.
  public class func createFile(named: String, path: String) -> URL? {
    let manager = FileManager()
    manager.createFile(atPath: "\(path)\(named).html", contents: nil, attributes: nil)
    return URL(fileURLWithPath: "\(path)\(named).html")
  }
  
  /// Deletes file with given name at given path.
  public class func deleteFile(named: String, path: String) throws {
    let manager = FileManager()
    do {
      try manager.removeItem(atPath: path + named + ".html")
    } catch let error {
      throw error
    }
  }
  
  /// Returns content from file as `String`, usually effective for testing.
  public class func getRenderedContent(from filename: String, path: String = "/tmp/") throws -> String {
    let manager = FileManager()
    guard let data = manager.contents(atPath: path + filename + ".html") else {
      throw VauxFileHelperError.noFile
    }
    guard let string = String(data: data, encoding: .utf8) else {
      throw VauxFileHelperError.badData
    }
    return string
  }
}
