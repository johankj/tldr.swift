import Foundation
import PrettyColors

class Page {
    var title = ""
    var descriptions: [String] = []
    var examples: [(String, String)] = []
    
    convenience init?(withName name: String) {
        guard let path = NSBundle.mainBundle().pathForResource(name, ofType: "md", inDirectory: "Resources") else { return nil }
        do {
            let fileContents = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            self.init(content: fileContents)
        } catch {
            return nil
        }
    }
    
    init(content: String) {
        parsePage(content)
    }
    
    func parsePage(content: String) {
        var regex = try! NSRegularExpression(pattern: "#(.*)", options: [])
        var matches = regex.matchesInString(content, options:[], range:NSMakeRange(0, content.characters.count))
        for match in matches {
            if let replaceRange = content.rangeFromNSRange(match.rangeAtIndex(1)) {
                title += content[replaceRange].trim()
            }
        }
        
        regex = try! NSRegularExpression(pattern: "(>(.*))+", options: [])
        matches = regex.matchesInString(content, options:[], range:NSMakeRange(0, content.characters.count))
        for match in matches {
            if let replaceRange = content.rangeFromNSRange(match.rangeAtIndex(2)) {
                descriptions += [content[replaceRange].trim()]
            }
        }
        
        regex = try! NSRegularExpression(pattern: "(-(.*)\\n+`(.*)`)+", options: [])
        matches = regex.matchesInString(content, options:[], range:NSMakeRange(0, content.characters.count))
        for match in matches {
            if let replaceRange1 = content.rangeFromNSRange(match.rangeAtIndex(2)),
               let replaceRange2 = content.rangeFromNSRange(match.rangeAtIndex(3)) {
                examples += [(content[replaceRange1].trim(), content[replaceRange2])]
            }
        }
        
    }
    
    func prettyPrint() {
        print("")
        print(" ", Color.Wrap(foreground: .Yellow, style: .Bold).wrap(title))
        for desc in descriptions {
            print(" ", desc)
        }
        print("")
        
        let descriptionColor = Color.Wrap(foreground: .Green)
        let commandColor = Color.Wrap(foreground: .Red)
        // let argsColor = Color.Wrap(foreground: .Yellow)
        for (desc, example) in examples {
            print(descriptionColor.wrap("  - \(desc)"))
            // code.0 contains ANSI-codes for enabling the color and code.1 for disabling
            let example = example.replace(["{{", "}}"], withStrings: ["\(commandColor.code.1)", "\(commandColor.code.0)"])
            print("    \(commandColor.code.0)\(example)\(commandColor.code.1)")
            print("")
        }
    }
}