import Foundation

// MARK: - HTMLOutputStream
/// A helper class for rendering formatted HTML to a given `TextOutputStream`.
public class HTMLOutputStream {
    var output: TextOutputStream
    
    /// Create an `HTMLOutputStream` that will render `HTML` nodes as HTML text.
    public init(_ output: TextOutputStream) {
        self.output = output
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
        write("\n")
    }
    func write<Str: StringProtocol>(_ text: Str) {
        output.write(String(text))
    }
    func writeDoubleQuoted(_ string: String) {
        write("\"")
        write(string)
        write("\"")
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

enum VauxError: Error {
}

public class Vaux {
    public enum VauxOutput {
        case stdout
        case file(name: String)
        
    }
    
    public var outputLocation: VauxOutput = .stdout
    
    public func render(_ content: HTML) throws {
        var stream: HTMLOutputStream?
        switch outputLocation {
        case .stdout:
            stream = HTMLOutputStream(FileHandle.standardOutput)
            break
        case .file(let filename):
            do {
                stream = HTMLOutputStream(try FileHandle(forWritingTo: VauxFileHelper.createFile(named: filename)))
            } catch let error {
                throw error
            }
        }
        content.renderAsHTML(into: stream!, attributes: [])
    }
}

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        write(Data(string.utf8))
    }
}

