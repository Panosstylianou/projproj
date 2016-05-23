//
//  Model.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 14/11/2015.
//  Copyright © 2015 Panayiotis Stylianou. All rights reserved.
//

import Foundation
import CoreData

class LessonModel:NSManagedObject{
    
    @NSManaged
    var title: String
    
//    @NSManaged
//    var steps: [Step]
    
    func addTitle(title:String){
        self.title = title
    }
}

//class Step:NSManagedObject{
//    
//    @NSManaged
//    var text: String
//    
//    @NSManaged
//    var step: NSNumber
//    
//    @NSManaged
//    var image: NSData?
//    
////    @NSManaged
////    var code: NSString
//}