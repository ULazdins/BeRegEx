import Foundation

public struct End: RegexComponent {
    public init() {}
    
    public func compile() -> String {
        return "$"
    }
}
