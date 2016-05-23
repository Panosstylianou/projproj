//
//  CreateViewController.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 02/11/2015.
//  Copyright © 2015 Panayiotis Stylianou. All rights reserved.
//

import Cocoa
import Carbon
import Foundation



class CreateViewController: NSViewController {
    @IBOutlet weak var secondLabel: NSTextField!
    
    @IBOutlet weak var screenshot: NSImageView!
    private var monitor: FolderMonitor!
    @IBOutlet weak var firstLabel: NSTextField!
    var lesson : [(String, NSData?)] = []
    var tempImage : NSData!
    var lessonObj : Lesson?
    

    var count : Int = 0
    @IBOutlet var textField: NSTextView!
//    var myLesson:Lesson

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        
        
        // Do view setup here.
    }

    
    func hotkeyWithEventC(hkEvent : NSEvent){
        
        let url = NSURL(fileURLWithPath: ("~/Desktop" as NSString).stringByExpandingTildeInPath)
        let dir = NSString(string:"~/Desktop").stringByExpandingTildeInPath
        let filemanager = NSFileManager.defaultManager()
        let itemsOld = try! filemanager.contentsOfDirectoryAtPath(dir)

         monitor = monitor ?? FolderMonitor(url: url, handler: {
            
            let items = try! filemanager.contentsOfDirectoryAtPath(dir)
            let old = itemsOld
            
            var imagePath : String
            let result = Set(items).subtract(Set(old))

            let sorted = result.sort({ x, y in
                return x.localizedStandardCompare(y) == NSComparisonResult.OrderedAscending
            })
//            var ourPath : String
            
            if(sorted.count>0){
                let ourPath = sorted.last!
                let pathCount = ourPath.characters.count - 3
                let tempresult = String(ourPath.characters.dropFirst(pathCount))
                
                if(tempresult == "png"){
                    imagePath = dir + "/" + result.first!
                }else{
                    imagePath = dir + "/" + String(result.first!.characters.dropLast(5).dropFirst())

                }
    //                self.tempImage = NSImage(contentsOfURL: NSURL(fileURLWithPath: imagePath))

                if let imageString = NSImage(contentsOfURL: NSURL(fileURLWithPath: imagePath))?.TIFFRepresentation{
                    self.tempImage = imageString
                    if let imageData = NSImage(data: imageString){
                            self.screenshot.image = imageData
                    }
                }
    //                let imagestr = imageString?.base64EncodedDataWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
                
                    do{
        //                try filemanager.moveItemAtPath(imagePath, toPath: destination)
                            try filemanager.removeItemAtPath(imagePath)

                    }catch{
                        print("Error")
                    }
                
                for item in items{
                    
                    if item.hasPrefix("png"){
                        
                        print(item)
                    }
                }
            }
        })

    }
    
    func dataToImage(data:NSData?) -> (NSImage?){
        var image : NSImage
        if(data != nil){
           image = NSImage(data: data!)!
            return image
        }else{
            return nil
        }
    }
    
    func imageToData(image:NSImage?) -> (NSData?){
        
        if(image == nil){
            return nil
        }else{
            return image?.TIFFRepresentation
        }
    }

    @IBAction func btnSave(sender: AnyObject) {
        
//        lessonObj.setValue("test", forKey: "title")

//        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Lesson", inManagedObjectContext: self.managedObjectContext) as! Lesson
        
//        newItem.title = "THis is the title"
        
        var mySet = Set<Step>()
        var count = 0
        for step in lesson{
            
//            let element = NSEntityDescription.insertNewObjectForEntityForName("Step", inManagedObjectContext: self.managedObjectContext) as! Step
//            element.step = count
//            element.text = step.0
//            element.image = step.1
            
            count++
            
//            mySet.insert(element)
            
        }
//        newItem.steps = mySet
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(lessonObj!)
        let dir = NSString(string:"~/Desktop").stringByExpandingTildeInPath
        
        NSKeyedArchiver.archiveRootObject(data, toFile: dir)
        
//        if let fetchedRequest = NSFetchRequest(entityName: "Lesson"){
//            
//        }
        //                     let fetchResults = managedObjectContext.executeFetchRequest(fetchedRequest) as? [Lesson]{

        
//        do{
//            try{
//                     let fetchResults = managedObjectContext.executeFetchRequest(fetchedRequest) as? [Lesson]{
//            
//        }
//            }
//        }



        data.writeToFile(dir, atomically: true)
        
        
        
    }
    

    
    func previewElement(count:Int){
        
        textField.string = (lesson[count].0)
        let image = dataToImage(lesson[count].1)

//        let image = (NSImage(data:lesson[count].1!))
        screenshot.image = image
        
        
        if(count>0){
            firstLabel.stringValue = lesson[count-1].0
            if(count>1){
                secondLabel.stringValue = lesson[count-2].0
            }else{
                secondLabel.stringValue = ""
                
            }
        }else{
            firstLabel.stringValue = ""
        }
    }

    func hotkeyWithEventZ(hkEvent : NSEvent){
        if(count>0){

            if(lesson.count == count){
                let stepTuple: (String, NSData?) = (textField.string!,imageToData(self.screenshot.image))
                lesson.insert(stepTuple, atIndex: count)
                
            }else if(lesson.count>count){
                let stepTuple: (String, NSData?) = (textField.string!,imageToData(self.screenshot.image))
                lesson[count] = stepTuple
            }

            
            count--
            textField.string = (lesson[count].0)
            self.screenshot.image = dataToImage(lesson[count].1)
//            self.screenshot.image = NSImage(data: lesson[count].1!)

            tempImage = lesson[count].1
            
            if(count>0){
                firstLabel.stringValue = lesson[count-1].0
                if(count>1){
                    secondLabel.stringValue = lesson[count-2].0
                }else{
                    secondLabel.stringValue = ""
                    
                }
            }else{
                firstLabel.stringValue = ""
            }
        }
        print(count)
    }
    
    func hotkeyWithEventX(hkEvent : NSEvent){
        
        if((textField.string) != ""){
            
            if(lesson.count > count+1){
                
                
                lesson[count].0 = textField.string!
                lesson[count].1 = self.tempImage
                
                textField.string = (lesson[count+1].0)
                self.screenshot.image = dataToImage(lesson[count+1].1)

//                self.screenshot.image = NSImage(data: lesson[count+1].1!)
                tempImage = lesson[count+1].1
                
            }else if(lesson.count == count+1){
                let stepTuple: (String, NSData?) = (textField.string!,self.tempImage)
                lesson[count]=stepTuple
                
                textField.string = ""
                self.screenshot.image = nil
                
                
                
                
            }else{
                
                let stepTuple: (String, NSData?) = (textField.string!,imageToData(self.screenshot.image))
                
//                lesson.append(stepTuple)
                lesson.insert(stepTuple, atIndex: count)
                
//                let step = NSEntityDescription.insertNewObjectForEntityForName("Step", inManagedObjectContext: self.managedObjectContext) as! Step
//                step.text = textField.string!
//                step.image = self.tempImage
                
//                self.lessonObj.steps.append(step)
                
//                lesson.addObject(stepSet)
                textField.string?.removeAll()
                self.screenshot.image = nil
                


            }
            count++

            if(count>0){
                firstLabel.stringValue = lesson[count-1].0

                if(count>1){
                    secondLabel.stringValue = lesson[count-2].0
                }else{
                    secondLabel.stringValue = ""
                }
            }else{
                firstLabel.stringValue = ""
            }

            
            
        }else{
            print("There is no text")
        }
        print(count)
    }
    
    
    @IBAction func create(sender: AnyObject) {
        
        let z: DDHotKeyCenter = DDHotKeyCenter.sharedHotKeyCenter()
        
        if((z.registerHotKeyWithKeyCode(UInt16(kVK_ANSI_Z), modifierFlags: NSEventModifierFlags.ControlKeyMask.rawValue, target: self, action: Selector("hotkeyWithEventZ:"), object: nil) == nil)){
            print("Unable to register")
        }else{
        }
        
        let x: DDHotKeyCenter = DDHotKeyCenter.sharedHotKeyCenter()
        
        if((x.registerHotKeyWithKeyCode(UInt16(kVK_ANSI_X), modifierFlags: NSEventModifierFlags.ControlKeyMask.rawValue, target: self, action: Selector("hotkeyWithEventX:"), object: nil) == nil)){
            print("Unable to register")
        }else{
        }
        
        let c: DDHotKeyCenter = DDHotKeyCenter.sharedHotKeyCenter()
        
        if((c.registerHotKeyWithKeyCode(UInt16(kVK_ANSI_C), modifierFlags: NSEventModifierFlags.ControlKeyMask.rawValue, target: self, action: Selector("hotkeyWithEventC:"), object: nil) == nil)){
            print("Unable to register")
        }else{
        }
    }
    
}
