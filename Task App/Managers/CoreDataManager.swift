//
//  CoreDataManager.swift
//  Task App
//
//  Created by Logan Miller on 1/2/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "ListItemModel")
        persistentContainer.loadPersistentStores{(description, error) in
            if let error = error {
                fatalError("Core data store failed \(error.localizedDescription)")
            }
        }
    }
    
    // Save the items
    func saveItem(title: String, desc: String)
    {
        let listItem = ListItem(context: persistentContainer.viewContext)
        listItem.title = title
        listItem.desc = desc
        
        do{
           try persistentContainer.viewContext.save()
        }catch{
            print("Failed to save item \(error)")
        }
    }
    
    // Delete the item
    func deleteItem(listItem: ListItem){
        persistentContainer.viewContext.delete(listItem)
        
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    // Update the information on the app
    func updateItem(){
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    // Fetch all of the items in the database
    func getAllItems() -> [ListItem]{
        let fetchRequest: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
}
