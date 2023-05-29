//
//  Topic+CoreDataProperties.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var title: String?

}
