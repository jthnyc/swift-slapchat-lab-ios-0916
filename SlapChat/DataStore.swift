//
//  DataStore.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    static let sharedInstance = DataStore()
    
    private init() {}
    
    var messages = [Message]()
    
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
    
    
    func doomsdayDelete(){
        
       let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        do{
         let fetchedMessages = try context.fetch(fetchRequest)
            for message in messages {
                context.delete(message)
            }
            
        }catch {
            
        }

        
        saveContext()
        
        
    }
    
    func generateTestData(){
        // 1. declare where context is, which is in persistentcontainer.viewcontext (core data's "house") which has a property called viewcontext so we can access context. Type of ManageObjectContext.
        let managedContext = self.persistentContainer.viewContext
        
        // 2A: create an entity -- to make a message object
        /*
        let entity = NSEntityDescription.entity(forEntityName: "Message", in: managedContext)
        guard let unwrappedEntity = entity else { return }
        let message1 = NSManagedObject(entity: unwrappedEntity, insertInto: managedContext) as! Message
        */
    
        // 2. make a message a new way
        let message1 = Message(context: managedContext)
        message1.content = "Hello"
        message1.createAt = NSDate()
        
        let message2 = Message(context: managedContext)
        message2.content = "Bye"
        message2.createAt = NSDate()
        
        // save it because we made a change, house renovated
        saveContext()
        
        // saved but need to check if it's there -- and grab that data to use
        fetchData()
    
    }
    
    func fetchData() {
        let manageObjectContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")

        do {
            let fetchedMessages = try manageObjectContext.fetch(fetchRequest)
            let sortedMessages = fetchedMessages.sorted(by: { (messageA, messageB) -> Bool in
                
                if let unwrappedDateA = messageA.createAt, let unwrappedDateB = messageB.createAt {
                    
                    let dateA = unwrappedDateA as! Date
                    let dateB = unwrappedDateB as! Date
                    
                    return dateA > dateB
                }
                
                return false
            })
            
            self.messages = sortedMessages
            
//            if sortedMessages.count == 0 {
//                generateTestData()
//            }
            
        } catch {
            
        }
    

    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlapChat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
