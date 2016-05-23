//
//  WebsiteVC.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 17/05/2016.
//  Copyright © 2016 Panayiotis Stylianou. All rights reserved.
//

import Foundation
import Alamofire
import HTMLReader

class WebsiteVC: NSViewController
{
    var allString: String = ""
    var steps: [Step]?
    
    let URLString = "https://www.raywenderlich.com/97014/use-cocoapods-with-swift"
    
    @IBOutlet weak var getButton: NSButton!
    
    
    @IBOutlet weak var textField: NSTextField!
    
    
    
    
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func getWebsite(sender: AnyObject) {
        
        let website = textField.stringValue
        
//            getData(website)
//        getData("https://www.raywenderlich.com/97014/use-cocoapods-with-swift")

            fetchSteps { (_) in
                
                
        }
    }

    
    func getData(stringUrl: String)
    {
        let url = NSURL(string: stringUrl)
        
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                print(data)
                
                if error == nil {
                    
                    var urlContent = NSString(data: data!, encoding: NSASCIIStringEncoding) as String!

                    
//                    print(urlContent)
                }
            })
            task.resume()
        }
    }
    
//    private func parseHTMLRow(rowElement: HTMLElement) -> Step? {
//        var url: NSURL?
//        var number: Int?
//        var scale: Int?
//        var title: String?
//        // first column: URL and number
//        if let firstColumn = rowElement.childAtIndex(1) as? HTMLElement {
//            // skip the first row, or any other where the first row doesn't contain a number
//            if let urlNode = firstColumn.firstNodeMatchingSelector("a") {
//                if let urlString = urlNode.objectForKeyedSubscript("href") as? String {
//                    url = NSURL(string: urlString)
//                }
//                // need to make sure it's a number
//                let textNumber = firstColumn.textContent.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//                number = Int(textNumber)
//            }
//        }
//        if (url == nil || number == nil) {
//            return nil // can't do anything without a URL, e.g., the header row
//        }
//        
//        if let secondColumn = rowElement.childAtIndex(3) as? HTMLElement {
//            let text = secondColumn.textContent
//                .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//                .stringByReplacingOccurrencesOfString(",", withString: "")
//            scale = Int(text)
//        }
//        
//        if let thirdColumn = rowElement.childAtIndex(5) as? HTMLElement {
//            title = thirdColumn.textContent
//                .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//                .stringByReplacingOccurrencesOfString("\n", withString: "")
//        }
//        
//        if let title = title, url = url, number = number, scale = scale {
//            return Step(title: title, url: url, number: number, scale: scale)
//        }
//        return nil
//}

    private func isStepsTable(tableElement: HTMLElement) -> Bool {
        if tableElement.children.count > 0 {
            let firstChild = tableElement.childAtIndex(0)
            let lowerCaseContent = firstChild.textContent.lowercaseString
            allString = allString + lowerCaseContent
            if lowerCaseContent.containsString("number") && lowerCaseContent.containsString("scale") && lowerCaseContent.containsString("title") {
                return true
            }
        }
        return false
    }
    
    func fetchSteps(completionHandler: (NSError?) -> Void) {
        
        Alamofire.request(.GET, URLString)
            .responseString { responseString in
                guard responseString.result.error == nil else {
                    completionHandler(responseString.result.error!)
                    return
                    
                }
                guard let htmlAsString = responseString.result.value else {
                    let error = Error.errorWithCode(.StringSerializationFailed, failureReason: "Could not get HTML as String")
                    completionHandler(error)
                    return
                }
                
                let doc = HTMLDocument(string: htmlAsString)
                
                // find the table of charts in the HTML
                let tables = doc.nodesMatchingSelector("p")
                var chartsTable:HTMLElement?
                for table in tables {
                    if let tableElement = table as? HTMLElement {
                        if self.isStepsTable(tableElement) {
                            for
                            chartsTable = tableElement
                            break
                        }
                    }
                }
                print(self.allString)
                
                // make sure we found the table of charts
                guard let tableContents = chartsTable else {
                    // TODO: create error
                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason: "Could not find charts table in HTML document")
                    completionHandler(error)
                    return
                }
                
                self.steps = []
                for row in tableContents.children {
                    if let rowElement = row as? HTMLElement { // TODO: should be able to combine this with loop above
//                        if let newChart = self.parseHTMLRow(rowElement) {
//                            self.steps?.append(newChart)
//                        }
                    }
                }
                completionHandler(nil)
        }
    }
    
    func getText(elements: [HTMLElement])
    {
        
    }

}







x