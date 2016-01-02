import Foundation
import PrettyColors
import CommandLine

let TLDR_VERSION = "beta"

func usageAndExit() {
    cli.printUsage()
    exit(EX_USAGE)
}

let cli = CommandLine()

let help = BoolOption(shortFlag: "h", longFlag: "help",
    helpMessage: "Prints a help message.")
let version = BoolOption(shortFlag: "v", longFlag: "version",
    helpMessage: "Prints the version number.")
let os = EnumOption<Page.OS>(shortFlag: "o", longFlag: "os",
    helpMessage: "Override the operating system [linux, osx, sunos, common]")
let update = BoolOption(shortFlag: "u", longFlag: "update",
    helpMessage: "Update the local cache.")

cli.addOptions(help, version, os, update)

let command = Positional(title: "commandName", metavar: nil, helpMessage: "The man page to read")
cli.addPositionals(command)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}
if help.value { usageAndExit() }
if version.value { print(TLDR_VERSION); exit(0) }
if update.value { TLDR.update(); exit(0) }

if let cmd = command.value as? String {
    if let page = Page(withName: cmd, os: os.value) {
        page.prettyPrint()
    } else {
        print("Page `\(cmd)` not found.")
        print("Try updating with \"tldr --update\" or submit pull request to:")
        print("https://github.com/tldr-pages/tldr")
    }
} else {
    usageAndExit()
}
