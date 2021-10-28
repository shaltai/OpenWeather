//
//  DailyTemp+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension DailyTemp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyTemp> {
        return NSFetchRequest<DailyTemp>(entityName: "DailyTemp")
    }

    @NSManaged public var morn: Double
    @NSManaged public var night: Double
    @NSManaged public var eve: Double
    @NSManaged public var day: Double
    @NSManaged public var daily: Daily?

}

extension DailyTemp : Identifiable {

}
