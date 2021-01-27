import Foundation

public struct Exact: RegexComponent {
    let letters: String
    
    public init(_ letters: String) {
        self.letters = letters
    }
    
    public func compile() -> String {
        // Losely based on https://stackoverflow.com/questions/399078/
        // Note, there are multiple standards and different escaping rules
        // for different character positions
        let escaped = letters
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: ".", with: "\\.")
            .replacingOccurrences(of: "^", with: "\\^")
            .replacingOccurrences(of: "$", with: "\\$")
            .replacingOccurrences(of: "*", with: "\\*")
            .replacingOccurrences(of: "+", with: "\\+")
            .replacingOccurrences(of: "-", with: "\\-")
            .replacingOccurrences(of: "?", with: "\\?")
            .replacingOccurrences(of: "(", with: "\\(")
            .replacingOccurrences(of: ")", with: "\\)")
            .replacingOccurrences(of: "[", with: "\\[")
            .replacingOccurrences(of: "]", with: "\\]")
            .replacingOccurrences(of: "{", with: "\\{")
            .replacingOccurrences(of: "}", with: "\\}")
            .replacingOccurrences(of: "|", with: "\\|")
        return "\(escaped)"
    }
}
