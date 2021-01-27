import Foundation

public struct And: RegexComponent {
    let reg1: RegexComponent
    let reg2: RegexComponent
    
    public func compile() -> String {
        return "\(reg1.compile())\(reg2.compile())"
    }
}

extension RegexComponent {
    func and(_ reg: RegexComponent) -> RegexComponent {
        return And(reg1: self, reg2: reg)
    }
}
