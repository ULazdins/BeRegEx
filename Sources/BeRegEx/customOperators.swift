public func +(lhs: RegexComponent, rhs: RegexComponent) -> RegexComponent {
    return And(reg1: lhs, reg2: rhs)
}
