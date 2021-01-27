/**
 High level coponent that represents a part of a regular expression
 */

public protocol RegexComponent {
    /// Returns string representation (old-school regex)
    func compile() -> String
}
