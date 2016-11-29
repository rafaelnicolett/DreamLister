//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Rafael Nicoleti on 28/11/16.
//  Copyright © 2016 Rafael Nicoleti. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    override public func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.created = NSDate()
        
        
    }
}
