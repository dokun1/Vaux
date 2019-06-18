//
//  Errors.swift
//  
//
//  Created by David Okun on 6/7/19.
//

import Foundation

enum VauxFileHelperError: Error {
  case noFile
  case badData
}

extension VauxFileHelperError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .noFile:
      return "Vaux could not find a file at the path you specified."
    case .badData:
      return "Vaux was not able to use the data written to the file you specified."
    }
  }
}

enum VauxError: Error {

}
