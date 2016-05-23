//
//  ViewController.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 02/11/2015.
//  Copyright © 2015 Panayiotis Stylianou. All rights reserved.
//

import Cocoa
import Carbon
import AppKit

class MainVC: NSViewController {

    @IBOutlet weak var firstLabel: NSTextField!
    @IBOutlet weak var secondLabel: NSTextField!
    @IBOutlet weak var thirdLabel: NSTextField!
    @IBOutlet weak var largeImage: NSImageView?

    @IBOutlet weak var smallImage: NSImageView?
    var count: Int = 0
    var lesson :NSMutableArray = []
    var picture :NSMutableArray = []
    var zoomed :Bool = false
//    var lessonObj:Lesson = Lesson.init(name: "Lesson1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = -1

        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func populateLesson(){
        let array :NSMutableArray = []
        array.addObject("Step 1")
        array.addObject("Step 2")
        array.addObject("Step 3")
        array.addObject("Step 4")
        array.addObject("Step 5")
        array.addObject("Step 6")
        
        let pictures:NSMutableArray = []
        pictures.addObject(NSImage(named: "image1")!)
        pictures.addObject(NSImage(named: "image2")!)
        pictures.addObject(NSImage(named: "image3")!)
        pictures.addObject(NSImage(named: "image4")!)
        pictures.addObject(NSImage(named: "image5")!)
        pictures.addObject(NSImage(named: "image6")!)
        

        
//        lessonObj.addStep("Step1", image: NSImage(named: "image1")!)
//        lessonObj.addStep("Step2", image: NSImage(named: "image2")!)          No Lesson Object
//        lessonObj.addStep("Step3", image: NSImage(named: "image3")!)
//        lessonObj.addStep("Step4", image: NSImage(named: "image4")!)
//        lessonObj.addStep("Step5", image: NSImage(named: "image5")!)
//        lessonObj.addStep("Step6", image: NSImage(named: "image6")!)

        lesson = array
        picture = pictures
//        let dir = NSString(string:"~/Desktop").stringByExpandingTildeInPath
//
//        NSKeyedArchiver.archiveRootObject(lessonObj, toFile: dir + lessonObj.name)
//        let data = NSKeyedArchiver.archivedDataWithRootObject(lessonObj)
//        data.writeToFile(dir, atomically: true)
//        lessonObj.save()

//        No Lesson Object
        
    }
    
    func getDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func addPicture(picture : NSImage){
        smallImage!.image = picture
        smallImage!.hidden = false
        largeImage!.hidden = true
        
        zoomed = false
        largeImage!.image = nil
        smallImage!.layer = CALayer()

    }
    
    func addZoomedPicture(picture : NSImage){
        largeImage!.image = picture
        largeImage!.hidden = false
        smallImage!.hidden = true

        zoomed = true
        smallImage!.image = nil
        largeImage!.layer = CALayer()
    }
    
    
    func hotkeyWithEventZ(hkEvent : NSEvent){
        if(count>0){
            count--
//            
//            let dictionary = lessonObj.data.objectAtIndex(count)
//            let str = dictionary["text"]
//            let image = dictionary["image"]!
//            
//            
//            addOutput(str as!String)
//            addPicture(image as! NSImage )
            
//            No Lesson Object
        }
    }
    
    func hotkeyWithEventX(hkEvent : NSEvent){
//        if(count<lessonObj.data.count-1){             No Lesson Object
//            count++
//            
//            let dictionary = lessonObj.data.objectAtIndex(count)
//            let str = dictionary["text"]
//            let image = dictionary["image"]!
//            
//            addOutput(str as! String)
//            addPicture(image as! NSImage)
//        }else{
//            addOutput("Lesson Finished")
//            count = lessonObj.data.count
//        }
        
    }
    
    func hotkeyWithEventC(hkEvent : NSEvent){
        if(!zoomed){
            addZoomedPicture((smallImage?.image)!)
        }else{
            addPicture((largeImage?.image)!)
        }
    }
    @IBAction func goToWebsite
        (sender: AnyObject) {
        
        
        self.performSegueWithIdentifier("websiteSegue", sender: nil)

    }
    
    @IBAction func create(sender: AnyObject) {
        unregister()
        self.performSegueWithIdentifier("createSegue", sender: nil)
    }
    
    @IBAction func lessons(sender: AnyObject) {
        
        
        self.performSegueWithIdentifier("lessonsSegue", sender: nil)
    }
    
    @IBAction func start(sender: AnyObject) {
        self.populateLesson()
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
        

//        }
//        _btnStart.setTransparent(true)
//        _btnStart.setHidden(true)
//        _btnStart.setEnabled(false)

        
    }
    
    
    func addOutput(newOutput: String) {
        firstLabel.stringValue = newOutput
        
        
        if count > 0 {
//            secondLabel.stringValue = lessonObj.data.objectAtIndex(count-1)["text"] as! String 
//            No Lesson Object
        }else{
            secondLabel.stringValue = ""
        }
        if count > 1 {
//            thirdLabel.stringValue = lessonObj.data.objectAtIndex(count-2)["text"] as! String
//            No Lesson Object
        }else{
            thirdLabel.stringValue = ""
        }
    }
    
    func unregister(){
        let x : DDHotKeyCenter = DDHotKeyCenter.sharedHotKeyCenter()
        let z : DDHotKeyCenter = DDHotKeyCenter.sharedHotKeyCenter()
        let c : DDHotKeyCenter = DDHotKeyCenter.sharedHotKeyCenter()
        
        

        c.unregisterHotKeyWithKeyCode(UInt16(kVK_ANSI_C), modifierFlags: NSEventModifierFlags.ControlKeyMask.rawValue)
        x.unregisterHotKeyWithKeyCode(UInt16(kVK_ANSI_X), modifierFlags: NSEventModifierFlags.ControlKeyMask.rawValue)
        z.unregisterHotKeyWithKeyCode(UInt16(kVK_ANSI_Z), modifierFlags: NSEventModifierFlags.ControlKeyMask.rawValue)
        
        print("Unregistered")
    }
    

}
