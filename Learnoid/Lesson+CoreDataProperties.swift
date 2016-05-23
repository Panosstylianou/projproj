//
//  Lesson+CoreDataProperties.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 20/11/2015.
//  Copyright © 2015 Panayiotis Stylianou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lesson {

    @NSManaged var title: String?
    @NSManaged var steps: NSSet?

}
