//
//  Step.swift
//  Learnoid
//
//  Created by Panayiotis Stylianou on 18/05/2016.
//  Copyright © 2016 Panayiotis Stylianou. All rights reserved.
//

import Foundation

class Step {
    let title: String
    let number: Int
    let description: String
//    let code: String?
//    let image: NSImage?
    
    required init(title: String, number: Int, description: String)
    {
        self.title = title
        self.number = number
        self.description = description
    }

    
}
