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

// MARK - open up messages in new window in Chrome
do {
   openLinksInChrome()
}
