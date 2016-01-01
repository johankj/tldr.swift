import Foundation

class TLDR {
    static func update() {
        let fileManager = NSFileManager.defaultManager()
        let tldrPath = ("~/.tldr" as NSString).stringByExpandingTildeInPath
        let tmpFolder = NSTemporaryDirectory() + "/" + NSProcessInfo.processInfo().globallyUniqueString
        
        do {
            try fileManager.createDirectoryAtPath(tmpFolder, withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectoryAtPath(tldrPath + "/cache", withIntermediateDirectories: true, attributes: nil)
            
            let downloadURL = NSURL(string: "https://github.com/tldr-pages/tldr/archive/master.zip")!
            
            let data = try NSData(contentsOfURL: downloadURL, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            if data.writeToFile(tmpFolder + "/master.zip", atomically: true) {
                let task = NSTask()
                task.launchPath = "/usr/bin/unzip"
                task.arguments = [tmpFolder + "/master.zip", "tldr-master/pages/*", "-d", tmpFolder + "/"]
                task.standardOutput = NSPipe()
                task.launch()
                
                while task.running {
                    // NSTask.waitUntilExit is considered harmful
                }
                
                if fileManager.fileExistsAtPath(tldrPath + "/cache/pages") {
                    try fileManager.removeItemAtPath(tldrPath + "/cache/pages")
                }
                try fileManager.moveItemAtPath(tmpFolder + "/tldr-master/pages", toPath: tldrPath + "/cache/pages")
                
                print("Successfully updated the cache.")
            } else {
                print("Could not update cache. (File could not be saved)")
            }
        } catch {
            print("Could not update cache. (\(error))")
        }
    }
    
    static func defaultOS() -> Page.OS {
        return .OSX
    }
}