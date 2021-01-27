import Foundation

public struct Capture: RegexComponent {
    let reg: RegexComponent
    
    public func compile() -> String {
        return "(\(reg.compile()))"
    }
}

extension RegexComponent {
    public func capture() -> RegexComponent {
        return Capture(reg: self)
    }
}
