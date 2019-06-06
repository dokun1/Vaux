//
//  File.swift
//  
//
//  Created by David Okun on 6/6/19.
//

import Foundation

enum VauxFileHelperError: Error {
    case noFile
    case badData
}

public class VauxFileHelper {
    public class func createFile(named: String, path: String = "/tmp/") -> URL {
        let manager = FileManager()
        manager.createFile(atPath: "\(path)\(named).html", contents: nil, attributes: nil)
        return URL(fileURLWithPath: "\(path)\(named).html")
    }
    
    public class func deleteFile(named: String, path: String = "/tmp/") {
        let manager = FileManager()
        try? manager.removeItem(atPath: path + named + ".html")
    }
    
    public class func getString(from filename: String, path: String = "/tmp/") throws -> String {
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

