//
//  HTMLOutputStream.swift
//
//
//  Created by David Okun on 6/6/19.
//

import Foundation

// MARK: - HTMLOutputStream
/// A helper class for rendering formatted HTML to a given `TextOutputStream`.
public class HTMLOutputStream {
  var output: TextOutputStream
  
  /// Create an `HTMLOutputStream` that will render `HTML` nodes as HTML text.
  public init(_ output: TextOutputStream, _ tag: String?) {
    self.output = output
    if tag == "html" {
      write("<!DOCTYPE html>")
      writeNewline()
    }
  }
  
  var indentation: Int = 0
  
  func withIndent(_ f: () -> Void) {
    indentation += 2
    f()
    indentation -= 2
  }
  
  func writeIndent() {
    write(String(repeating: " ", count: indentation))
  }
  
  func line<Str: StringProtocol>(_ line: Str) {
    writeIndent()
    write(line)
    writeNewline()
  }
  
  func write<Str: StringProtocol>(_ text: Str) {
    output.write(String(text))
  }
  
  func writeDoubleQuoted(_ string: String) {
    write("\"")
    write(string)
    write("\"")
  }
  
  func writeNewline() {
    write("\n")
  }
  
  func writeCarriageReturn() {
    write("\r")
  }
  
  func writeEscaped<Str: StringProtocol>(_ string: Str) {
    for c in string {
      switch c {
      case "\"": write("&quot;")
      case "&": write("&amp;")
      case "<": write("&lt;")
      case ">": write("&gt;")
      default: write(String(c))
      }
    }
  }
  
  /// Renders the provided `HTML` node as HTML text to the receiver's stream.
  public func render(_ content: HTML) {
    content.renderAsHTML(into: self, attributes: [])
  }
}

extension FileHandle: TextOutputStream {
  public func write(_ string: String) {
    write(Data(string.utf8))
  }
}
