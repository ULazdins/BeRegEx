import Foundation

public struct ZeroOrMore: RegexComponent {
    let reg: RegexComponent
    
    public func compile() -> String {
        return "\(reg.compile())*"
    }
}

extension RegexComponent {
    public func zeroOrMore() -> RegexComponent {
        return ZeroOrMore(reg: self)
    }
}
