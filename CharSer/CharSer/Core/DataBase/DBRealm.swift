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
    
}

//MARK: Users
extension DBRealm{
    func getUsetsCount() -> (Int) {
        let realm = try! Realm()
        
        let users = realm.objects(ReferenceUser.self)
        
        return users.count
    }
    
    func getUsersList() ->([User]?) {
        let realm = try! Realm()
        
        let usersDB = realm.objects(ReferenceUser.self)
        
        if usersDB.count == 0 {
          return nil
        }
        
        var users = [User]()
        
        users = usersDB.map{ userDB in
            let user = User()
            user.first_name = userDB.first_name
            user.last_name = userDB.last_name
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
        
        userBD.first_name = user.first_name
        userBD.last_name = user.last_name
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

