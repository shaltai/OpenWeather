//
//  HourlyWeather+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension HourlyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyWeather> {
        return NSFetchRequest<HourlyWeather>(entityName: "HourlyWeather")
    }

    @NSManaged public var icon: String?
    @NSManaged public var iconURL: URL?
    @NSManaged public var hourly: Hourly?

}

extension HourlyWeather : Identifiable {

}
