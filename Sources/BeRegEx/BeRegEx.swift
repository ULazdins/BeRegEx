import Foundation

public extension RegexComponent {
    func match(_ string: String) -> [Result] {
        let range = NSRange(location: 0, length: string.utf8.count)
        
        let regex = try! NSRegularExpression(pattern: self.compile())
        let matches = regex.matches(
            in: string,
            options: [],
            range: range
        )
        
        return matches.map { result in
            var match: Substring?
            var captures: [Substring] = []
            
            for i in 0..<(regex.numberOfCaptureGroups + 1) {
                let matchRange = result.range(at: i)
                
                let substring = string[Range(matchRange, in: string)!]
                
                if (i == 0) {
                    match = substring
                } else {
                    captures.append(substring)
                }
            }
            
            return Result(
                match: match,
                captures: captures,
                namedCaptures: [:]
            )
        }
    }
}
