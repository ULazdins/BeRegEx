import Foundation

public enum AsciiCharacterSet {
    case lowercaseLetters
    case uppercaseLetters
    case letters
    case numbers
    case alphanumerics
    case custom(String)
}

public struct AnyOf: RegexComponent {
    let s: String
    
    public func compile() -> String {
        return "[\(s)]"
    }
    
    public init(_ chars: AsciiCharacterSet...) {
        let mapped = chars.map { char -> String in
            switch char {
            case .letters:
                return "a-zA-Z"
            case .lowercaseLetters:
                return "a-z"
            case .uppercaseLetters:
                return "A-Z"
            case .numbers:
                return "0-9"
            case .alphanumerics:
                return "a-zA-Z0-9"
            case .custom(let customChars):
                return customChars
            }
        }
        self.s = mapped.joined(separator: "")
    }
}
