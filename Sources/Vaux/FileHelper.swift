//
//  FileHelper.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

public struct Filepath {
  public var name: String
  public var path: String

  public init(name: String, path: String) {
    self.path = path
    self.name = name
  }
}

public class VauxFileHelper {
  /// Allows you to create a `.html` file with a given name and given path.
  public class func createFile(_ file: Filepath) -> URL? {
    let manager = FileManager()
    manager.createFile(atPath: "\(file.path)\(file.name).html", contents: nil, attributes: nil)
    return URL(fileURLWithPath: "\(file.path)\(file.name).html")
  }

  /// Deletes file with given name at given path.
  public class func deleteFile(_ file: Filepath) throws {
    let manager = FileManager()
    do {
      try manager.removeItem(atPath: file.path + file.name + ".html")
    } catch let error {
      throw error
    }
  }

  /// Returns content from file as `String`, usually effective for testing.
  public class func getRenderedContent(from file: Filepath) throws -> String {
    let manager = FileManager()
    let fullPath = file.path + file.name + ".html"
    guard let data = manager.contents(atPath: fullPath) else {
      throw VauxFileHelperError.noFile
    }
    guard let string = String(data: data, encoding: .utf8) else {
      throw VauxFileHelperError.badData
    }
    return string
  }
}
