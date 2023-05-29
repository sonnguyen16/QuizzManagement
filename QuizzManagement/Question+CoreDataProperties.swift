//
//  Question+CoreDataProperties.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var text: String?
    @NSManaged public var answer1: String?
    @NSManaged public var answer2: String?
    @NSManaged public var answer3: String?
    @NSManaged public var answer4: String?
    @NSManaged public var correctAnswer: String?
    @NSManaged public var to_one: Topic?
}
