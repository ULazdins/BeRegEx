import Foundation

public struct Between: RegexComponent {
    let reg: RegexComponent
    let range: ClosedRange<Int>
    
    public func compile() -> String {
        return "\(reg.compile()){\(range.lowerBound),\(range.upperBound)}"
    }
}

extension RegexComponent {
    public func between(_ range: ClosedRange<Int>) -> RegexComponent {
        return Between(reg: self, range: range)
    }
}
