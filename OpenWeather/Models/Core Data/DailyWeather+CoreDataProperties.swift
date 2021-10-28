//
//  DailyWeather+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension DailyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyWeather> {
        return NSFetchRequest<DailyWeather>(entityName: "DailyWeather")
    }

    @NSManaged public var icon: String?
    @NSManaged public var iconURL: URL?
    @NSManaged public var daily: Daily?

}

extension DailyWeather : Identifiable {

}
