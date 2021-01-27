import Foundation

public struct Start: RegexComponent {
    public init() {}
    
    public func compile() -> String {
        return "^"
    }
}
