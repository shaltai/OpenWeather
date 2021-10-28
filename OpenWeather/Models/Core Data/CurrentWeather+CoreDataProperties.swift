//
//  CurrentWeather+CoreDataProperties.swift
//  OpenWeather
//
//  Created by Stanislav Pimenov on 19.10.2021.
//
//

import Foundation
import CoreData


extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "CurrentWeather")
    }

    @NSManaged public var main: String?
    @NSManaged public var descr: String?
    @NSManaged public var icon: String?
    @NSManaged public var iconURL: URL?
    @NSManaged public var current: Current?

}

extension CurrentWeather : Identifiable {

}
