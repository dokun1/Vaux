import Foundation

enum VauxError: Error {
}

public class Vaux {
    public enum VauxOutput {
        case stdout
        case file(name: String, path: String)
    }
    
    public init() { }
    
    public var outputLocation: VauxOutput = .stdout
    
    private func getStream() throws -> HTMLOutputStream {
        switch outputLocation {
        case .stdout:
            return HTMLOutputStream(FileHandle.standardOutput)
        case .file(let filename, let path):
            do {
                guard let url = VauxFileHelper.createFile(named: filename, path: path) else {
                    throw VauxFileHelperError.noFile
                }
                let handler = try FileHandle(forWritingTo: url)
                return HTMLOutputStream(handler)
            } catch let error {
                throw error
            }
        }
    }
    
    public func render(_ content: HTML) throws {
        do {
            let stream = try getStream()
            content.renderAsHTML(into: stream, attributes: [])
        } catch let error {
            throw error
        }
    }
}

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        write(Data(string.utf8))
    }
}

