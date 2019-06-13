//
//  Enums.swift
//  
//
//  Created by David Okun on 6/12/19.
//

import Foundation


public enum Scope: String {
  case row = "row"
  case column = "column"
  case rowGroup = "rowgroup"
  case columnGroup = "colgroup"
}

public enum Alignment: String {
  case left = "left"
  case right = "right"
  case center = "center"
  case justified = "justified"
}

/// Heading weight for the heading tag.
public enum HeadingWeight: String {
  case h1 = "h1"
  case h2 = "h2"
  case h3 = "h3"
  case h4 = "h4"
  case h5 = "h5"
  case h6 = "h6"
}
