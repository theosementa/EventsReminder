//
//  CoreDataStack.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "EventsReminder")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No persistent store description found.")
        }
        
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
    #if DEBUG
   static var preview: CoreDataStack = {
       let stack = CoreDataStack()
       let viewContext = stack.persistentContainer.viewContext
       
       // Insérez des données factices pour les prévisualisations
       for _ in 0..<10 {
           let newItem = YourManagedObject(context: viewContext)
           newItem.name = "Sample"
           // Configurez d'autres propriétés selon vos besoins
       }
       
       do {
           try viewContext.save()
       } catch {
           fatalError("Error saving preview context: \(error)")
       }
       
       return stack
   }()
   #endif
}
