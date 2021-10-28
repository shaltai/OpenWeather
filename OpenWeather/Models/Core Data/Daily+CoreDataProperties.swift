//
//  Daily+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension Daily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Daily> {
        return NSFetchRequest<Daily>(entityName: "Daily")
    }

    @NSManaged public var dt: Date?
    @NSManaged public var dailyTemp: NSSet?
    @NSManaged public var dailyWeather: NSSet?

}

// MARK: Generated accessors for dailyTemp
extension Daily {

    @objc(addDailyTempObject:)
    @NSManaged public func addToDailyTemp(_ value: DailyTemp)

    @objc(removeDailyTempObject:)
    @NSManaged public func removeFromDailyTemp(_ value: DailyTemp)

    @objc(addDailyTemp:)
    @NSManaged public func addToDailyTemp(_ values: NSSet)

    @objc(removeDailyTemp:)
    @NSManaged public func removeFromDailyTemp(_ values: NSSet)

}

// MARK: Generated accessors for dailyWeather
extension Daily {

    @objc(addDailyWeatherObject:)
    @NSManaged public func addToDailyWeather(_ value: DailyWeather)

    @objc(removeDailyWeatherObject:)
    @NSManaged public func removeFromDailyWeather(_ value: DailyWeather)

    @objc(addDailyWeather:)
    @NSManaged public func addToDailyWeather(_ values: NSSet)

    @objc(removeDailyWeather:)
    @NSManaged public func removeFromDailyWeather(_ values: NSSet)

}

extension Daily : Identifiable {

}
