//
//  Hourly+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension Hourly {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hourly> {
        return NSFetchRequest<Hourly>(entityName: "Hourly")
    }

    @NSManaged public var dt: Date?
    @NSManaged public var temp: Double
    @NSManaged public var hourlyWeather: NSSet?

}

// MARK: Generated accessors for hourlyWeather
extension Hourly {

    @objc(addHourlyWeatherObject:)
    @NSManaged public func addToHourlyWeather(_ value: HourlyWeather)

    @objc(removeHourlyWeatherObject:)
    @NSManaged public func removeFromHourlyWeather(_ value: HourlyWeather)

    @objc(addHourlyWeather:)
    @NSManaged public func addToHourlyWeather(_ values: NSSet)

    @objc(removeHourlyWeather:)
    @NSManaged public func removeFromHourlyWeather(_ values: NSSet)

}

extension Hourly : Identifiable {

}
