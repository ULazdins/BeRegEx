import Foundation

public struct OneOrMore: RegexComponent {
    let reg: RegexComponent
    
    public func compile() -> String {
        return "\(reg.compile())+"
    }
}

extension RegexComponent {
    public func oneOrMore() -> RegexComponent {
        return OneOrMore(reg: self)
    }
}
