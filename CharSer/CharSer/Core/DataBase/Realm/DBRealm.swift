//
//  DBRealm.swift
//  CharSer
//
//  Created by Андрей Закусов on 11.10.2020.
//

import Foundation
import RealmSwift

class DBRealm: DataBaseInterface {
    
    
    func setConfiguration() -> () {
        let config = Realm.Configuration(
            schemaVersion: 5
        )
        
        Realm.Configuration.defaultConfiguration = config
        
    }

}

extension DBRealm{
    //Соответствие между объектами базы данных и модели
    func getDBTypeByModelType(_ modelType: ReferenceModel) -> (ReferenceObjectDB){
        
        if let _ = modelType as? User {
            return ReferenceUser()
        }
        
        if let _ = modelType as? Customer {
            return ReferenceСustomer()
        }
        
        if let _ = modelType as? СhargObject {
            return ReferenceСhargObject()
        }
        
        return ReferenceUser() //до сюда в нормальной ситуации доходить не должно никогда
    }
    
    
}

//MARK: ReferenceObjectDB

extension DBRealm{
    
    func  getObjectsList(object: ReferenceModel) ->([ReferenceModel]?){
        let realm = try! Realm()
        
        
        let emptyModelObject = getDBTypeByModelType(object)
        
        let type = emptyModelObject.getObjetType()
        
        let objectsDB = realm.objects(type)
        
        if objectsDB.count == 0 {
          return nil
        }
        
        var objectsModel = [ReferenceModel]()
        
        objectsModel = objectsDB.map{ objectDB in
            
            let objectDB = objectDB as? ReferenceUser
            
            return objectDB?.getModelByObjectDB() ?? object
        }
        
        return objectsModel
    }
    
    func addObject(by object: ReferenceModel, update: Bool) -> (result: Bool, message: String) {
       
//        if !update, let _ = getCustomerByID(id: object.id) {
//            return (result: false, message: "Уже есть клиент с данным id")
//        }
        
        var object = object

        if !update {
            object.id = nextFreeID(by:object)
        }
        
       let objectDB = getDBTypeByModelType(object)
       objectDB.fillByModel(modelObject: object)
        
        guard let record = objectDB as? Object else {
            return (result: false, message: "Ошибка преобразования объекта")
        }
       
        let realm = try! Realm()
        try! realm.write {
           realm.add(record, update: .modified)
        }


       return (result: true, message: "")
    }
    
//    func getCustomerByID(id: Int) -> (Customer?) {
//        let realm = try! Realm()
//        
//        guard let customerDB = realm.objects(ReferenceСustomer.self).filter("id == %@", id).first else {
//            return nil
//        }
//        
//        let customer = Customer()
//        
//        customer.name = customerDB.name
//        customer.phone = customerDB.phone
//        customer.id = customerDB.id
//        
//        return customer
//    }
    
    func nextFreeID(by object: ReferenceModel) -> (Int) {
        let realm = try! Realm()
        
        let emptyModelObject = getDBTypeByModelType(object)
        
        let type = emptyModelObject.getObjetType()
        
        let objectsDB = realm.objects(type).filter("id.@max").last
        
        if let lastObject = objectsDB as? ReferenceObjectDB {
            return lastObject.id + 1
        }
        else {
            return 1
        }
    }
}



//MARK: Users
extension DBRealm{
    func getUsersCount() -> (Int) {
        let realm = try! Realm()
        
        let users = realm.objects(ReferenceUser.self)
        
        return users.count
    }
    
    func getUsersList() ->([User]?) {
        let realm = try! Realm()
        let type = ReferenceUser.self
        let usersDB = realm.objects(type)
        
        if usersDB.count == 0 {
          return nil
        }
        
        var users = [User]()
        
        users = usersDB.map{ userDB in
            let user = User()
            user.firstName = userDB.firstName
            user.lastName = userDB.lastName
            user.login = userDB.login
            if  userDB.role == "admin" {
                user.role = .admin
            }else if userDB.role == "user" {
                user.role = .user
            }
            return user
        }
        
        return users
    }
    
    func addUser(by user: User, update: Bool, updatePassword: Bool) -> (result: Bool, message: String) {
        if !update, let _ = getUserByLogin(login: user.login) {
            return (result: false, message: "Уже есть пользователь с таким логином")
        }
        
       let userBD = ReferenceUser()
        
        userBD.firstName = user.firstName
        userBD.lastName = user.lastName
        userBD.login = user.login
        userBD.role = user.role.rawValue
        if updatePassword {
        userBD.password = user.password
        }
        
        let realm = try! Realm()
        try! realm.write {
           realm.add(userBD, update: .modified)
        }
        
        
       return (result: true, message: "")
    }
    
    func getUserByLogin(login: String) -> (User?) {
        let realm = try! Realm()
        
        let usersDB = realm.objects(ReferenceUser.self).filter("login == %@", login).first
        
        if usersDB == nil {
          return nil
        }
        
        let user = User()
        
        user.firstName = usersDB?.firstName ?? ""
        user.lastName = usersDB?.lastName ?? ""
        user.login = usersDB?.login ?? ""
        if  usersDB?.role == "admin" {
            user.role = .admin
        }else if usersDB?.role == "user" {
            user.role = .user
        }
        
        return user
    }
    
    func login(login: String, password: String) -> (User?) {
        let realm = try! Realm()
        
        let usersDB = realm.objects(ReferenceUser.self).filter("login == %@ AND password == %@", login, password).first
        
        if usersDB == nil {
          return nil
        }
        
        let user = User()
        
        user.firstName = usersDB?.firstName ?? ""
        user.lastName = usersDB?.lastName ?? ""
        user.login = usersDB?.login ?? ""
        if  usersDB?.role == "admin" {
            user.role = .admin
        }else if usersDB?.role == "user" {
            user.role = .user
        }
        
        return user
    }
}

//MARK: Customers

extension DBRealm{
    
    func getCustomersList() ->([Customer]?) {
        let realm = try! Realm()
        
        let costomersDB = realm.objects(ReferenceСustomer.self)
        
        if costomersDB.count == 0 {
          return nil
        }
        
        var customers = [Customer]()
        
        customers = costomersDB.map{ customerDB in
            let customer = Customer()
            customer.name = customerDB.name
            customer.phone = customerDB.phone
            customer.id = customerDB.id
         
            return customer
        }
        
        return customers
    }
    
    func addCustomer(by customer: Customer, update: Bool) -> (result: Bool, message: String) {
        if !update, let _ = getCustomerByID(id: customer.id) {
            return (result: false, message: "Уже есть клиент с данным id")
        }

       let customerBD = ReferenceСustomer()

        customerBD.name = customer.name
        customerBD.phone = customer.phone
        customerBD.id = nextFreeCustomerID()

        let realm = try! Realm()
        try! realm.write {
           realm.add(customerBD, update: .modified)
        }


       return (result: true, message: "")
    }
    
    func getCustomerByID(id: Int) -> (Customer?) {
        let realm = try! Realm()
        
        guard let customerDB = realm.objects(ReferenceСustomer.self).filter("customerID == %@", id).first else {
            return nil
        }
        
        let customer = Customer()
        
        customer.name = customerDB.name
        customer.phone = customerDB.phone
        customer.id = customerDB.id
        
        return customer
    }
    
    func nextFreeCustomerID() -> (Int) {
        let realm = try! Realm()
        
        if let lastCustomer = realm.objects(ReferenceСustomer.self).filter("customerID.@max").last {
            return lastCustomer.id + 1
        }
        else {
            return 1
        }
    }
    
    
}

//MARK: СhargObjects

extension DBRealm{
    
    func getСhargObjectsList() ->([СhargObject]?) {
        let realm = try! Realm()
        
        let objectsDB = realm.objects(ReferenceСhargObject.self)
        
        if objectsDB.isEmpty {
          return nil
        }
        
        var objectsModel = [СhargObject]()
        
        objectsModel = objectsDB.map{ objectDB in
            return objectDB.getModelByObjectDB() as! СhargObject
        }
        
        return objectsModel
    }
    
    func addСhargObject(by сhargObject: СhargObject, update: Bool) -> (result: Bool, message: String) {
        if !update, let _ = getСhargObjectByID(id: сhargObject.id) {
            return (result: false, message: "Уже есть объект тарификации с данным id")
        }
        
        if !update {
            сhargObject.id = nextFreeСhargObjectID()
        }

       let customerBD = ReferenceСhargObject()
        customerBD.fillByModel(modelObject: сhargObject)
        
        let realm = try! Realm()
        try! realm.write {
           realm.add(customerBD, update: .modified)
        }


       return (result: true, message: "")
    }
    
    func getСhargObjectByID(id: Int) -> (СhargObject?) {
        let realm = try! Realm()
        
        guard let objectDB = realm.objects(ReferenceСhargObject.self).filter("id == %@", id).first else {
            return nil
        }
        
        return objectDB.getModelByObjectDB() as? СhargObject
    }
    
    func nextFreeСhargObjectID() -> (Int) {
        let realm = try! Realm()
        
        if let lastObject = realm.objects(ReferenceСhargObject.self).filter("id.@max").last {
            return lastObject.id + 1
        }
        else {
            return 1
        }
    }
    
    
}





