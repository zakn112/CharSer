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
    
    static var shared = DBCoreData()
    private init(){}
    
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
    
    func getObjectDB<T: NSManagedObject>(type: T.Type ,byID id: Int16) -> (T?) {
        let context = persistentContainer.viewContext
        
        let request = T.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %ld", id)
        request.predicate = predicate
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return nil
            }
            
            return objectsDB.first as? T ?? nil
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getObjectList<T: NSManagedObject & ReferenceObjectDB>(type: T.Type) ->([ReferenceModel]?) {
        let context = persistentContainer.viewContext
    
        let request = T.fetchRequest()
        
        do {
            let objectsDB = try context.fetch(request)
            
            var objectsModel = [ReferenceModel]()
            
            objectsModel = objectsDB.compactMap{ objectDB in
                if let objectDB = objectDB as? ReferenceObjectDB {
                    return objectDB.getModelByObjectDB()
                }
                return nil
            }
            
            return objectsModel
            
        } catch {
            print(error)
        }
        return nil
    }
    
    func addObject<T: NSManagedObject & ReferenceObjectDB>(type: T.Type , by object: ReferenceModel, update: Bool) -> (result: Bool, message: String) {
        let context = persistentContainer.viewContext
        var object = object
        var currentObject:T?
        
        let request = T.fetchRequest()
        
        let predicate = NSPredicate(format: "id == %ld", object.id)
        request.predicate = predicate
        
        do {
            currentObject = try context.fetch(request).first as? T
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
            let entityDescription = T.entity()
            currentObject = T(entity: entityDescription, insertInto: context)
        }
        
        guard let managedObject = currentObject else {
            return (result: false, message: "Ошибка при создании объекта базы данных")
        }
        
        if !update {
            object.id = nextFreeID(by: T.self)
        }
        managedObject.fillByModel(modelObject: object)
       
        // Запись объекта
        self.saveContext()
        
        return (result: true, message: "")
    }
    
    func nextFreeID<T: NSManagedObject>(by object: T.Type) -> (Int) {
        let context = persistentContainer.viewContext
        
        let request = T.fetchRequest()
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        request.sortDescriptors = [idSortDescriptor]
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return 1
            }
           
            return Int((objectsDB.first as? ReferenceObjectDB)?.id ?? 0) + 1
            
        } catch {
            print(error)
        }
        
        return 1
    }
    
}

//MARK: universal function

extension DBCoreData{
    
    func  getObjectsList(object: ReferenceModel.Type) ->([ReferenceModel]?){
        
        if object == Customer.self {
        
            return getObjectList(type: CDCustomers.self)
            
        }else if object == User.self {
            
            return getObjectList(type: CDUsers.self)
            
        }else if object == СhargObject.self {
            
            return getObjectList(type: CDChargObjects.self)
            
        }else if object == CustomerOrder.self {
            
            return getObjectList(type: CDCustomerOrders.self)
            
        }else if object == SetPrices.self {
            
            return getObjectList(type: CDSetPrices.self)
            
        }
        
        return nil
    }
    
    func addObject(by object: ReferenceModel, update: Bool) -> (result: Bool, message: String) {
        if type(of: object) == Customer.self {
        
            return addObject(type: CDCustomers.self, by: object, update: update)
            
        }else if type(of: object) == User.self {
            
            return addObject(type: CDUsers.self, by: object, update: update)
            
        }else if type(of: object) == СhargObject.self {
            
            return addObject(type: CDChargObjects.self, by: object, update: update)
            
        }else if type(of: object) == CustomerOrder.self {
            
            return addObject(type: CDCustomerOrders.self, by: object, update: update)
            
        }
        
        return (result: true, message: "")
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


//MARK: SetPrices

extension DBCoreData{
    
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
            managedObject.id = Int32(nextFreeID(by: CDSetPrices.self))
        }
        managedObject.date = setPrices.date
        if setPrices.chargObject == nil {
            managedObject.chargObject = nil
        }else{
            managedObject.chargObject = getObjectDB(type: CDChargObjects.self, byID: Int16(setPrices.chargObject!.id))
        }
        
        //Записываем табличную част
        //Удалим старые записит табличной части
        if let vtPricesDB = managedObject.vtPrices {
            for vtPricesDBItem in vtPricesDB {
                if let vtPricesItemDB = vtPricesDBItem as? CDSetPricesVTPrices {
                    context.delete(vtPricesItemDB)
                }
            }
        }
        
        let entityDescriptionCDSetPricesVTPrices = NSEntityDescription.entity(forEntityName: "CDSetPricesVTPrices", in: context)
        
        var strNumber:Int16 = 0
        for vtPricesItem in setPrices.vtPrices {
            let currentObjectVTPrices = CDSetPricesVTPrices(entity: entityDescriptionCDSetPricesVTPrices!, insertInto: context)
            
            currentObjectVTPrices.strNumber = strNumber
            currentObjectVTPrices.weekday = vtPricesItem.weekday
            currentObjectVTPrices.startTime = vtPricesItem.startTime
            currentObjectVTPrices.endTime = vtPricesItem.endTime
            currentObjectVTPrices.price = vtPricesItem.price
            
            currentObject?.addToVtPrices(currentObjectVTPrices)
            
            strNumber += 1
        }
        
        
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
            
            objectsModel = objectsDB.compactMap{ objectDB in
                return objectDB.getModelByObjectDB() as? SetPrices
            }
            
            return objectsModel.first
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getSetPricesLast() -> (SetPrices?) {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<CDSetPrices> = NSFetchRequest<CDSetPrices>(entityName: "CDSetPrices")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            let objectsDB = try context.fetch(request)
            
            if objectsDB.count == 0 {
                return nil
            }
            
            var objectsModel = [SetPrices]()
            
            objectsModel = objectsDB.compactMap{ objectDB in
                return objectDB.getModelByObjectDB() as? SetPrices
            }
            
            return objectsModel.first
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    
}
