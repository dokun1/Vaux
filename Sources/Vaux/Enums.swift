//
//  Enums.swift
//  
//
//  Created by David Okun on 6/12/19.
//

import Foundation

/// Determines the scope of a table heading cell
public enum Scope: String {
  case row = "row"
  case column = "column"
  case rowGroup = "rowgroup"
  case columnGroup = "colgroup"
}

/// Alignment of the content in a cell
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

public enum AreaShape: String {
  case `default`    = "default"
  case rectangular  = "rect"
  case circle       = "circle"
  case polygonal    = "poly"
}

public enum BaseTarget {
  case blank
  case `self`
  case parent
  case top
  case framename(String)
  
  var string: String {
    switch self {
    case .blank:
      return "_blank"
    case .`self`:
      return "_self"
    case .parent:
      return "_parent"
    case .top:
      return "_top"
    case .framename(let name):
      return name
    }
  }
}

public enum Direction: String {
  case leftToRight = "ltr"
  case rightToLeft = "rtl"
}

public enum ButtonType: String {
  case button = "button"
  case submit = "submit"
  case reset  = "reset"
}

public enum InputType: String {
    case button
    case checkbox
    case color
    case date
    case datetime_local = "datetime_local"
    case email
    case file
    case hidden
    case image
    case month
    case number
    case password
    case radio
    case range
    case reset
    case search
    case submit
    case tel
    case text
    case time
    case url
    case week
}

public enum FigureCaptionPosition {
    case top
    case bottom
}

public enum Meta {
    case name(String)
    case author(String)
    case description(String)
    case generator(String)
    case keywords(String)
    case viewport(String)
    
    public var name: String {
        switch self {
        case let .name(applicationName):
            return applicationName
        case .author:
            return "author"
        case .description:
            return "description"
        case .generator:
            return "generator"
        case .keywords:
            return "keywords"
        case .viewport:
            return "viewport"
        }
    }
    
    public var content: String? {
        switch self {
        case .name:
            return nil
        case let .author(author):
            return author
        case let .description(description):
            return description
        case let .generator(generator):
            return generator
        case let .keywords(keywords):
            return keywords
        case let .viewport(viewport):
            return viewport
        }
    }
}

/// MIME types.
/// - Note: The most "commons" have been retrieved from: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types
///
/// Two primary MIME types are important for the role of default types:
/// - `text/plain` is the default value for textual files. A textual file should be human-readable and must not contain binary data.
/// - `application/octet-stream` is the default value for all other cases. An unknown file type should use this type. Browsers pay a particular care when manipulating these files, attempting to safeguard the user to prevent dangerous behaviors.
public enum MIME: String {
  case aac        = "audio/aac"
  case abw        = "application/x-abiword"
  case arc        = "application/x-freearc"
  case avi        = "video/x-msvideo"
  case azw        = "application/vnd.amazon.ebook"
  case bin        = "application/octet-stream"
  case bmp        = "image/bmp"
  case bz         = "application/x-bzip"
  case bz2        = "application/x-bzip2"
  case csh        = "application/x-csh"
  case css        = "text/css"
  case csv        = "text/csv"
  case doc        = "application/msword"
  case docx       = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
  case eot        = "application/vnd.ms-fontobject"
  case epub       = "application/epub+zip"
  case gif        = "image/gif"
  case html       = "text/html"
  case ico        = "image/vnd.microsoft.icon"
  case ics        = "text/calendar"
  case jar        = "application/java-archive"
  case jpg        = "image/jpeg"
  case js         = "text/javascript"
  case json       = "application/json"
  case jsonld     = "application/ld+json"
  case midi       = "audio/midi audio/x-midi"
  case mp3        = "audio/mpeg"
  case mp4        = "video/mp4"
  case mpeg       = "video/mpeg"
  case mpkg       = "application/vnd.apple.installer+xml"
  case odp        = "application/vnd.oasis.opendocument.presentation"
  case ods        = "application/vnd.oasis.opendocument.spreadsheet"
  case odt        = "application/vnd.oasis.opendocument.text"
  case oga        = "audio/ogg"
  case ogv        = "video/ogg"
  case ogg        = "application/ogg"
  case otf        = "font/otf"
  case png        = "image/png"
  case pdf        = "application/pdf"
  case ppt        = "application/vnd.ms-powerpoint"
  case pptx       = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
  case rar        = "application/x-rar-compressed"
  case rtf        = "application/rtf"
  case sh         = "application/x-sh"
  case svg        = "image/svg+xml"
  case swf        = "application/x-shockwave-flash"
  case tar        = "application/x-tar"
  case tiff       = "image/tiff"
  case ts         = "video/mp2t"
  case ttf        = "font/ttf"
  case txt        = "text/plain"
  case vsd        = "application/vnd.visio"
  case wav        = "audio/wav"
  case weba       = "audio/webm"
  case webm       = "video/webm"
  case webp       = "image/webp"
  case woff       = "font/woff"
  case woff2      = "font/woff2"
  case xhtml      = "application/xhtml+xml"
  case xls        = "application/vnd.ms-excel"
  case xlsx       = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  case xmlBinary  = "application/xml" // if not readable from casual users (RFC 3023, section 3)
  case xml        = "text/xml" // if readable from casual users (RFC 3023, section 3)
  case xul        = "application/vnd.mozilla.xul+xml"
  case zip        = "application/zip"
  case _3gp       = "video/3gpp"
  case _3gpAudio  = "audio/3gpp" // if it doesn't contain video"
  case _3g2       = "video/3gpp2"
  case _3g2Audio  = "audio/3gpp2" // if it doesn't contain video"
  case _7zip      = "application/x-7z-compressed"
}

/// Create control for SVG path element.
public enum SVGPathControl {
    case moveto(Double, Double, Bool)
    case lineto(Double, Double, Bool)
    case horizontalLineto(Double, Double, Bool)
    case verticalLineto(Double, Double, Bool)
    case curveto(Double, Double, Bool)
    case smoothCurveto(Double, Double, Bool)
    case quadraticBézierCurve(Double, Double, Double?, Bool)
    case smoothQuadraticBézierCurveto(Double, Double, Double?, Bool)
    case ellipticalArc(Double, Double, Bool)
    case closePath
    case stop
    
    public var toString: String {
        switch self {
        case let .moveto(x, y, absolute):
            return "M".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case let .lineto(x, y, absolute):
            return "L".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case let .horizontalLineto(x, y, absolute):
            return "H".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case let .verticalLineto(x, y, absolute):
            return "V".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case let .curveto(x, y, absolute):
            return "C".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case let .smoothCurveto(x, y, absolute):
            return "S".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case let .quadraticBézierCurve(x, y, z, absolute):
            return "Q".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))\(z == nil ? "" : " \(String(format: "%g", z!))")"
        case let .smoothQuadraticBézierCurveto(x, y, z, absolute):
            return "T".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))\(z == nil ? "" : " \(String(format: "%g", z!))")"
        case let .ellipticalArc(x, y, absolute):
            return "A".case(absolute) + "\(String(format: "%g", x)) \(String(format: "%g", y))"
        case .closePath:
            return "Z"
        case .stop:
            return "0"
        }
    }
}

fileprivate extension String {
    func `case`(_ absolute: Bool) -> String {
        return absolute ? self.uppercased() : self.lowercased()
    }
}
