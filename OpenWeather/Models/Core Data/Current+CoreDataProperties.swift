//
//  Current+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension Current {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Current> {
        return NSFetchRequest<Current>(entityName: "Current")
    }

    @NSManaged public var temp: Double
    @NSManaged public var feels_like: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var pressure: Int16
    @NSManaged public var uvi: Double
    @NSManaged public var wind_speed: Double
    @NSManaged public var wind_deg: Double
    @NSManaged public var currentWeather: NSSet?

}

// MARK: Generated accessors for currentWeather
extension Current {

    @objc(addCurrentWeatherObject:)
    @NSManaged public func addToCurrentWeather(_ value: CurrentWeather)

    @objc(removeCurrentWeatherObject:)
    @NSManaged public func removeFromCurrentWeather(_ value: CurrentWeather)

    @objc(addCurrentWeather:)
    @NSManaged public func addToCurrentWeather(_ values: NSSet)

    @objc(removeCurrentWeather:)
    @NSManaged public func removeFromCurrentWeather(_ values: NSSet)

}

extension Current : Identifiable {

}
