//
//  PersistenceController.swift
//  EventsReminder
//
//  Created by KaayZenn on 12/05/2024.
//

import Foundation
import CoreData
import CloudKit

class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentCloudKitContainer
    
    private init() {
        // Définir le nom de l'application et le groupe d'applications
        let appName = "EventsReminder"
        let appGroup = "group.sementa.eventsreminder"
        
        // Créer l'URL du store
        let storeURL = URL.storeURL(for: appGroup, databaseName: appName)
        
        // Configurer la description du store
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        storeDescription.shouldInferMappingModelAutomatically = true
        storeDescription.shouldMigrateStoreAutomatically = true
        storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.sementa.eventsreminder")
        
        // Initialiser le conteneur persistant
        persistentContainer = NSPersistentCloudKitContainer(name: appName)
        persistentContainer.persistentStoreDescriptions = [storeDescription]
        
        loadPersistentStores()
    }
    
    private func loadPersistentStores() {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
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
}

public extension URL {
    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
