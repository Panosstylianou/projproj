//
//  Lesson.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 08/11/2015.
//  Copyright © 2015 Panayiotis Stylianou. All rights reserved.
//

import Cocoa

class Lesson: NSObject, NSCoding {
    
    var name:String = "New Lesson"
    var data:NSMutableArray = []
    
    init(name:String){
        self.name = name
    }
    
    func addStep(text:String, image:NSImage){
        
        let dict:Dictionary = ["text":text, "image":image]
        data.addObject(dict)
    }
    
    func addStep(text:String, code:String, image:NSImage){
        let dict:Dictionary = ["text":text, "code":code, "image":image]
        data.addObject(dict)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {

        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.data, forKey: "data")
    }
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        data = aDecoder.decodeObjectForKey("data") as! NSMutableArray
        
    }
    
    func save(){
        
        let dir = NSString(string:"~/Desktop").stringByExpandingTildeInPath
        let savedData = NSKeyedArchiver.archivedDataWithRootObject(self)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(savedData, forKey: "lesson")
        
        let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lessons")
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self, toFile: ArchiveURL.path!)
        
        NSFileManager.defaultManager().createFileAtPath(dir, contents: savedData, attributes: nil)
//        NSKeyedArchiver.archiveRootObject(self, toFile: dir + name)
//        NSKeyedArchiver.archiveRootObject(self, toFile: "lesson.bin")
        NSKeyedArchiver.archiveRootObject(self, toFile: "/path/to/archive")

//        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
//        
//        
//        data.writeToFile(dir, atomically: true)
        
    }

}
