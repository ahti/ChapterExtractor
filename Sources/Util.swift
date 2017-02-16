import Foundation

extension Collection where Indices.Iterator.Element == Index {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct FailureMessage {
    let exitCode: Int32
    let message: String
}

public struct StderrOutputStream: TextOutputStream {
    public mutating func write(_ string: String) {
        fputs(string, stderr)
    }
}

func fail(_ message: FailureMessage) -> Never {
    var errStream = StderrOutputStream()
    print(message.message, to: &errStream)
    exit(message.exitCode)
}
