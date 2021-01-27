import Foundation

public struct Result: CustomStringConvertible {
    let match: Substring?
    let captures: [Substring]
    let namedCaptures: [String: Substring]
    
    public var description: String {
        return "match: \(match ?? "-"), captures: \(captures)"
    }
}

extension Result: Equatable {
    public static func ==(lhs: Result, rhs: Result) -> Bool {
        return lhs.match == rhs.match &&
            lhs.captures == rhs.captures &&
            lhs.namedCaptures == rhs.namedCaptures
    }
}

