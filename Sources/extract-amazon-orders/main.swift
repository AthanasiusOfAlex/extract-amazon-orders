import Foundation
import AmazonOrderExtractor

let outputFile: URL

// MARK - deal with command line
do {
    if CommandLine.arguments.count <= 1 {
        outputFile = URL(fileURLWithPath: "/dev/stdout")
    } else {
        outputFile = URL(fileURLWithPath: CommandLine.arguments[1])
    }
}

//// MARK - Check to see if the file exists.
//do {
//    func fileExists() -> Bool {
//        let url = outputFile.absoluteURL.deletingLastPathComponent()
//        let fileManager = FileManager.default
//        
//        print(url.absoluteString)
//        print(fileManager.fileExists(atPath: url.absoluteString))
//        return fileManager.fileExists(atPath: url.absoluteString)
//    }
//    
//    guard fileExists() else { exit(1) }
//}

// Print out the links
do {
    printListOfLinks(outFileUrl: outputFile)
}
