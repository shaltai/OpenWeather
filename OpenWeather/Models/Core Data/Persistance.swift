import Foundation
import CoreData

class Persistance {
   static let shared = Persistance()
   
   // Core Data
   lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "WeatherModel")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
      return container
   }()
   
   // Save context
   func saveContext(context: NSManagedObjectContext) {
      guard context.hasChanges else { return }
      do {
         try context.save()
      } catch let error as NSError {
         print("Error: \(error), \(error.userInfo)")
      }
   }

}
