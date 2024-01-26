//
//  CoreDataManager.swift
//  Trading Journal
//
//  Created by Dilpreet Singh on 27/01/24.
//  Copyright © 2024 Dilpreet Singh. All rights reserved.
//

import CoreData

// MARK: - CoreDataManager
class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "TraderDataModel")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Core Data store failed to load: \(error.localizedDescription)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save context: \(error.localizedDescription)")
            }
        }
    }

    func fetchRecentNotes() -> [TradeNote] {
        let request: NSFetchRequest<TradeNote> = TradeNote.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]

        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch {
            fatalError("Failed to fetch notes: \(error.localizedDescription)")
        }
    }
}
