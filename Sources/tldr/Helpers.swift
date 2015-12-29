import Foundation

extension String {
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
           let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    func replace(targets: [String], withStrings: [String]) -> String {
        var mutate = self
        for i in 0..<targets.count {
            mutate = mutate.replace(targets[i], withString: withStrings[i])
        }
        return mutate
    }
}
