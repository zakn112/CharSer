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
            schemaVersion: 2
        )
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    func getUsetsCount() -> (Int) {
        let realm = try! Realm()
        
        let users = realm.objects(ReferenceUser.self)
        
        return users.count
    }
    
    func createUser(by user: User) -> (result: Bool, message: String) {
        if let _ = getUserByLogin(login: user.login) {
            return (result: false, message: "Уже есть пользователь с таким логином")
        }
        
       let userBD = ReferenceUser()
        
        userBD.first_name = user.first_name
        userBD.last_name = user.last_name
        userBD.login = user.login
        userBD.password = user.password
        userBD.role = user.role.rawValue
        
        let realm = try! Realm()
        try! realm.write {
               realm.add(userBD)
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
        
        user.first_name = usersDB?.first_name ?? ""
        user.last_name = usersDB?.last_name ?? ""
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
        
        user.first_name = usersDB?.first_name ?? ""
        user.last_name = usersDB?.last_name ?? ""
        user.login = usersDB?.login ?? ""
        if  usersDB?.role == "admin" {
            user.role = .admin
        }else if usersDB?.role == "user" {
            user.role = .user
        }
        
        return user
    }
    
}

