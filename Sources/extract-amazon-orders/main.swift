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

// MARK - print the messages

public extension Date {
    
    private func getName(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public func getMonthName() -> String { return getName(withFormat: "MM") }
    public func getYearName() -> String { return getName(withFormat: "yyyy") }
    public func getDayName() -> String { return getName(withFormat: "dd") }
}

do {
    func runAppleScript(script: String) {
        let script = NSAppleScript(source: script)!
        var dict = NSDictionary()
        withUnsafeMutablePointer(to: &dict) {
            let errorInfo = AutoreleasingUnsafeMutablePointer<NSDictionary?>($0)
            script.executeAndReturnError(errorInfo)
        }
    }
    
    let desktop = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    let outputFolderURL = desktop.appendingPathComponent("PDF").absoluteString
    let outputFolder = outputFolderURL.suffix(outputFolderURL.count - 7)
    print(outputFolder)
    let today = Date()
    let year = today.getYearName()
    let month = today.getMonthName()
    let day = today.getDayName()
    
    let script = """
tell application "Google Chrome"
    set myWindow to front window
    set myTabs to tabs in myWindow
    set outputFolder to "\(outputFolder)"
    set myCount to 0
    
    activate
    
    set myDelay to 0.2

    repeat with myTab in myTabs
        set myCount to myCount + 1
        set fileName to "\(year)-\(month)-\(day)-amazon-nnnn" & myCount & ".pdf"
        set outputPath to outputFolder & fileName
        
        --N.B.: the following opens the system print window, not Google Chrome’s
        tell myTab to print
        
        tell application "System Events"
            tell process "Google Chrome"
                repeat until window "Print" exists
                    delay myDelay
                end repeat
                
                set printWindow to window "Print"
                
                tell printWindow
                    set myButton to menu button "PDF"
                    click myButton
                    
                    repeat until exists menu 1 of myButton
                        delay myDelay
                    end repeat
                    
                    set myMenu to menu 1 of myButton
                    set myMenuItem to menu item "Save as PDF" of myMenu
                    click myMenuItem
                    
                    repeat until exists sheet 1
                        delay myDelay
                    end repeat
                    
                    set saveSheet to sheet 1
                    tell saveSheet
                        set value of first text field to fileName
                        keystroke "g" using {command down, shift down}
                        
                        repeat until exists sheet 1 of saveSheet
                            delay myDelay
                        end repeat
                        
                        set goDialogue to sheet 1 of saveSheet
                        
                        tell goDialogue
                            set value of first combo box to outputFolder
                            click button "Go"
                        end tell
                        
                        click button "Save"
                    end tell
                end tell
                
                repeat while printWindow exists
                    delay myDelay
                end repeat
            end tell
        end tell
    end repeat
end tell
"""
    runAppleScript(script: script)
    
}
