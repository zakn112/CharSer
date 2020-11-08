//
//  DBCoreData.swift
//  CharSer
//
//  Created by Андрей Закусов on 01.11.2020.
//

import Foundation
import UIKit
import CoreData

class DBCoreData: DataBaseInterface {
    
    func setConfiguration() -> () {
       
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CharSer")
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

//MARK: ReferenceObjectDB

extension DBCoreData{
    
    func  getObjectsList(object: ReferenceModel) ->([ReferenceModel]?){
        
        
        return nil
    }
    
    func addObject(by object: ReferenceModel, update: Bool) -> (result: Bool, message: String) {
       
       return (result: true, message: "")
    }
    
    func nextFreeID(by object: ReferenceModel) -> (Int) {
            return 1
    }
}



//MARK: Users
extension DBCoreData{
    func getUsersCount() -> (Int) {
        let context = persistentContainer.viewContext
    
        let request: NSFetchRequest<CDUsers> = NSFetchRequest<CDUsers>(entityName: "CDUsers")
        //Нужно явное указание типа, чтобы разбить неопределённость между методом класса и тем, что достался от objc
        
        do {
            let lists = try context.fetch(request)
            
            return lists.count
        } catch {
            print(error)
        }
        
        return 0
    }
    
    func getUsersList() ->([User]?) {
        let context = persistentContainer.viewContext
    
        let request: NSFetchRequest<CDUsers> = NSFetchRequest<CDUsers>(entityName: "CDUsers")
        //Нужно явное указание типа, чтобы разбить неопределённость между методом класса и тем, что достался от objc
        
        do {
            let usersDB = try context.fetch(request)
            
            var users = [User]()
            
            users = usersDB.map{ userDB in
                let user = User()
                
                user.firstName = userDB.firstName ?? ""
                user.lastName = userDB.lastName ?? ""
                user.login = userDB.login ?? ""
                if  userDB.role == "admin" {
                    user.role = .admin
                }else if userDB.role == "user" {
                    user.role = .user
                }
                return user
            }
            
            return users
            
        } catch {
            print(error)
        }
        return nil
    }
    
    func addUser(by user: User, update: Bool, updatePassword: Bool) -> (result: Bool, message: String) {
        let context = persistentContainer.viewContext
        var currentObject:CDUsers?
        
        let request: NSFetchRequest<CDUsers> = NSFetchRequest<CDUsers>(entityName: "CDUsers")
        
        let predicate = NSPredicate(format: "login == %@", user.login)
        request.predicate = predicate
        
        do {
            currentObject = try context.fetch(request).first
        } catch {
            print(error)
        }
        
        
        if update, currentObject == nil {
            return (result: false, message: "Не найден объект базы данных для обновления")
        }
        
        if !update, currentObject != nil {
            return (result: false, message: "Уже есть пользователь с таким логином")
        }
        
        if !update {
            // Описание сущности
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDUsers", in: context)
            
            // Создание нового объекта
            currentObject = CDUsers(entity: entityDescription!, insertInto: context)
        }
        
        guard let managedObject = currentObject else {
            return (result: false, message: "Ошибка при создании объекта базы данных")
        }
        
        // Установка значения атрибута
        managedObject.login = user.login
        managedObject.firstName = user.firstName
        managedObject.lastName = user.lastName
        managedObject.role = user.role.rawValue
        
        if updatePassword {
            managedObject.password = user.password
        }
        
        // Запись объекта
        self.saveContext()
        
        return (result: true, message: "")
    }
    
    func getUserByLogin(login: String) -> (User?) {
        let context = persistentContainer.viewContext
    
        let request: NSFetchRequest<CDUsers> = NSFetchRequest<CDUsers>(entityName: "CDUsers")

        let predicate = NSPredicate(format: "login == %@", login)
        request.predicate = predicate
        
        do {
            let usersDB = try context.fetch(request)
            
            if usersDB.count == 0 {
                return nil
            }
            
            var users = [User]()
            
            users = usersDB.map{ userDB in
                let user = User()
                
                user.firstName = userDB.firstName ?? ""
                user.lastName = userDB.lastName ?? ""
                user.login = userDB.login ?? ""
                if  userDB.role == "admin" {
                    user.role = .admin
                }else if userDB.role == "user" {
                    user.role = .user
                }
                return user
            }
            
            return users.first
            
        } catch {
            print(error)
        }

        return nil
    }
    
    func login(login: String, password: String) -> (User?) {
        
        let context = persistentContainer.viewContext
    
        let request: NSFetchRequest<CDUsers> = NSFetchRequest<CDUsers>(entityName: "CDUsers")

        let predicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
        request.predicate = predicate
        
        do {
            let usersDB = try context.fetch(request)
            
            if usersDB.count == 0 {
                return nil
            }
            
            var users = [User]()
            
            users = usersDB.map{ userDB in
                let user = User()
                
                user.firstName = userDB.firstName ?? ""
                user.lastName = userDB.lastName ?? ""
                user.login = userDB.login ?? ""
                if  userDB.role == "admin" {
                    user.role = .admin
                }else if userDB.role == "user" {
                    user.role = .user
                }
                return user
            }
            
            return users.first
            
        } catch {
            print(error)
        }

        return nil
        
    }
}

//MARK: Customers

extension DBCoreData{
    
    func getCustomersList() ->([Customer]?) {
        let context = persistentContainer.viewContext
    
        let request: NSFetchRequest<CDCustomers> = NSFetchRequest<CDCustomers>(entityName: "CDCustomers")
        //Нужно явное указание типа, чтобы разбить неопределённость между методом класса и тем, что достался от objc
        
        do {
            let objectsDB = try context.fetch(request)
            
            var objectsModel = [Customer]()
            
            objectsModel = objectsDB.map{ objectDB in
                let objectModel = Customer()
                objectModel.id = Int(objectDB.id)
                objectModel.name = objectDB.name ?? ""
                objectModel.phone = objectDB.phone ?? ""
                
                return objectModel
            }
            
            return objectsModel
            
        } catch {
            print(error)
        }
        return nil
    }
    
    func addCustomer(by customer: Customer, update: Bool) -> (result: Bool, message: String) {
        let context = persistentContainer.viewContext
        var currentObject:CDCustomers?
        
        let request: NSFetchRequest<CDCustomers> = NSFetchRequest<CDCustomers>(entityName: "CDCustomers")
        
        let predicate = NSPredicate(format: "id == %ld", customer.id)
        request.predicate = predicate
        
        do {
            currentObject = try context.fetch(request).first
        } catch {
            print(error)
        }
        
        
        if update, currentObject == nil {
            return (result: false, message: "Не найден объект базы данных для обновления")
        }
        
        if !update, currentObject != nil {
            return (result: false, message: "Уже есть объект тарификации с таким id")
        }
        
        if !update {
            // Описание сущности
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDCustomers", in: context)
            
            // Создание нового объекта
            currentObject = CDCustomers(entity: entityDescription!, insertInto: context)
        }
        
        guard let managedObject = currentObject else {
            return (result: false, message: "Ошибка при создании объекта базы данных")
        }
        
        // Установка значения атрибута
        if !update {
            managedObject.id = Int32(nextFreeCustomerID())
        }
        managedObject.name = customer.name
        managedObject.phone = customer.phone
       
        // Запись объекта
        self.saveContext()
        
        return (result: true, message: "")
    }
    
    func getCustomerByID(id: Int) -> (Customer?) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDCustomers> = NSFetchRequest<CDCustomers>(entityName: "CDCustomers")
        
        let predicate = NSPredicate(format: "id == %ld", id)
        request.predicate = predicate
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return nil
            }
            
            var objectsModel = [Customer]()
            
            objectsModel = objectsDB.map{ objectDB in
                let objectModel = Customer()
                objectModel.id = Int(objectDB.id)
                objectModel.name = objectDB.name ?? ""
                objectModel.phone = objectDB.phone ?? ""
                return objectModel
            }
            
            return objectsModel.first
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func nextFreeCustomerID() -> (Int) {
       
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDCustomers> = NSFetchRequest<CDCustomers>(entityName: "CDCustomers")
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [idSortDescriptor]
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return 1
            }
            
            return Int(objectsDB.first?.id ?? 0) + 1
            
        } catch {
            print(error)
        }
        
        return 1
        
    }
    
    
}

//MARK: СhargObjects

extension DBCoreData{
    
    func getСhargObjectsList() ->([СhargObject]?) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDChargObjects> = NSFetchRequest<CDChargObjects>(entityName: "CDChargObjects")
        //Нужно явное указание типа, чтобы разбить неопределённость между методом класса и тем, что достался от objc
        
        do {
            let objectsDB = try context.fetch(request)
            
            var objectsModel = [СhargObject]()
            
            objectsModel = objectsDB.map{ objectDB in
                let objectModel = СhargObject()
                objectModel.id = Int(objectDB.id)
                objectModel.name = objectDB.name ?? ""
                objectModel.startTime = objectDB.startTime ?? Date()
                objectModel.shutdownTime = objectDB.shutdownTime ?? Date()
                
                return objectModel
            }
            
            return objectsModel
            
        } catch {
            print(error)
        }
        return nil
    }
    
    func addСhargObject(by сhargObject: СhargObject, update: Bool) -> (result: Bool, message: String) {
        let context = persistentContainer.viewContext
        var currentObject:CDChargObjects?
        
        let request: NSFetchRequest<CDChargObjects> = NSFetchRequest<CDChargObjects>(entityName: "CDChargObjects")
        
        let predicate = NSPredicate(format: "id == %ld", сhargObject.id)
        request.predicate = predicate
        
        do {
            currentObject = try context.fetch(request).first
        } catch {
            print(error)
        }
        
        
        if update, currentObject == nil {
            return (result: false, message: "Не найден объект базы данных для обновления")
        }
        
        if !update, currentObject != nil {
            return (result: false, message: "Уже есть объект тарификации с таким id")
        }
        
        if !update {
            // Описание сущности
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDChargObjects", in: context)
            
            // Создание нового объекта
            currentObject = CDChargObjects(entity: entityDescription!, insertInto: context)
        }
        
        guard let managedObject = currentObject else {
            return (result: false, message: "Ошибка при создании объекта базы данных")
        }
        
        // Установка значения атрибута
        if !update {
            managedObject.id = Int32(nextFreeСhargObjectID())
        }
        managedObject.name = сhargObject.name
        managedObject.startTime = сhargObject.startTime
        managedObject.shutdownTime = сhargObject.shutdownTime
        
        // Запись объекта
        self.saveContext()
        
        return (result: true, message: "")
    }
    
    func getСhargObjectByID(id: Int) -> (СhargObject?) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDChargObjects> = NSFetchRequest<CDChargObjects>(entityName: "CDChargObjects")
        
        let predicate = NSPredicate(format: "id == %ld", id)
        request.predicate = predicate
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return nil
            }
            
            var objectsModel = [СhargObject]()
            
            objectsModel = objectsDB.map{ objectDB in
                let objectModel = СhargObject()
                objectModel.id = Int(objectDB.id)
                objectModel.name = objectDB.name ?? ""
                objectModel.startTime = objectDB.startTime ?? Date()
                objectModel.shutdownTime = objectDB.shutdownTime ?? Date()
                return objectModel
            }
            
            return objectsModel.first
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func nextFreeСhargObjectID() -> (Int) {
        
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDChargObjects> = NSFetchRequest<CDChargObjects>(entityName: "CDChargObjects")
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [idSortDescriptor]
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return 1
            }
            
            return Int(objectsDB.first?.id ?? 0) + 1
            
        } catch {
            print(error)
        }
        
        return 1
        
    }
    
    
}


//MARK: SetPrices

extension DBCoreData{
    
    func getSetPricesList() ->([SetPrices]?) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDSetPrices> = NSFetchRequest<CDSetPrices>(entityName: "CDSetPrices")
        
        do {
            let objectsDB = try context.fetch(request)
            
            var objectsModel = [SetPrices]()
            
            objectsModel = objectsDB.map{ objectDB in
                let objectModel = SetPrices()
                objectModel.id = Int(objectDB.id)
                objectModel.date = objectDB.date ?? Date()
                
                return objectModel
            }
            
            return objectsModel
            
        } catch {
            print(error)
        }
        return nil
    }
    
    func addSetPrices(by setPrices: SetPrices, update: Bool) -> (result: Bool, message: String) {
        let context = persistentContainer.viewContext
        var currentObject:CDSetPrices?
        
        let request: NSFetchRequest<CDSetPrices> = NSFetchRequest<CDSetPrices>(entityName: "CDSetPrices")
        
        let predicate = NSPredicate(format: "id == %ld", setPrices.id)
        request.predicate = predicate
        
        do {
            currentObject = try context.fetch(request).first
        } catch {
            print(error)
        }
        
        
        if update, currentObject == nil {
            return (result: false, message: "Не найден объект базы данных для обновления")
        }
        
        if !update, currentObject != nil {
            return (result: false, message: "Уже есть объект с таким id")
        }
        
        if !update {
            // Описание сущности
            let entityDescription = NSEntityDescription.entity(forEntityName: "CDSetPrices", in: context)
            
            // Создание нового объекта
            currentObject = CDSetPrices(entity: entityDescription!, insertInto: context)
        }
        
        guard let managedObject = currentObject else {
            return (result: false, message: "Ошибка при создании объекта базы данных")
        }
        
        // Установка значения атрибута
        if !update {
            managedObject.id = Int32(nextFreeSetPricesID())
        }
        managedObject.date = setPrices.date
        
        
        // Запись объекта
        self.saveContext()
        
        return (result: true, message: "")
    }
    
    func getSetPricesByID(id: Int) -> (SetPrices?)  {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDSetPrices> = NSFetchRequest<CDSetPrices>(entityName: "CDSetPrices")
        
        let predicate = NSPredicate(format: "id == %ld", id)
        request.predicate = predicate
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return nil
            }
            
            var objectsModel = [SetPrices]()
            
            objectsModel = objectsDB.map{ objectDB in
                let objectModel = SetPrices()
                objectModel.id = Int(objectDB.id)
                objectModel.date = objectDB.date ?? Date()
                
                return objectModel
            }
            
            return objectsModel.first
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func nextFreeSetPricesID() -> (Int) {
        
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDSetPrices> = NSFetchRequest<CDSetPrices>(entityName: "CDSetPrices")
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [idSortDescriptor]
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return 1
            }
            
            return Int(objectsDB.first?.id ?? 0) + 1
            
        } catch {
            print(error)
        }
        
        return 1
        
    }
    
    
}
