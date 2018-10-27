//
//  Appointment+CoreDataProperties.swift
//  Project
//
//  Created by Pakaporn on 10/19/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import Foundation
import CoreData


extension Appointment {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Appointment> {
        return NSFetchRequest<Appointment>(entityName: "Appointment")
    }
    
    @NSManaged public var cost: String?
    @NSManaged public var date: Date
    @NSManaged public var dateCreated: Date
    @NSManaged public var dateModified: Date?
    @NSManaged public var note: String?
    @NSManaged public var patient: Patient
    
    
}

