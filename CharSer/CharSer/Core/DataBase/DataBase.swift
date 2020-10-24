//
//  DataBase.swift
//  CharSer
//
//  Created by Андрей Закусов on 13.10.2020.
//

import Foundation

protocol DataBaseInterface {
    
    func setConfiguration() -> ()
    
    func getUsetsCount() -> (Int)
    func getUsersList() ->([User]?)
    func addUser(by user: User, update: Bool, updatePassword: Bool) -> (result: Bool, message: String)
    func getUserByLogin(login: String) -> (User?)
    func login(login: String, password: String) -> (User?)
    
}

class DataBase: DataBaseInterface {
    
    static var shared: DataBaseInterface = DataBase()
    private let currentDataBase = DBRealm()
    
    private init(){}
    
    func setConfiguration() {
        currentDataBase.setConfiguration()
    }
    
    
}

//MARK: Users

extension DataBase{
    
    func getUsetsCount() -> (Int) {
       return currentDataBase.getUsetsCount()
    }
    func getUsersList() ->([User]?){
        return currentDataBase.getUsersList()
    }
    func addUser(by user: User, update: Bool, updatePassword: Bool) -> (result: Bool, message: String) {
        return currentDataBase.addUser(by: user, update: update, updatePassword: updatePassword)
    }
    
    func getUserByLogin(login: String) -> (User?) {
        return currentDataBase.getUserByLogin(login: login)
    }
    
    func login(login: String, password: String) -> (User?) {
       return currentDataBase.login(login: login, password: password)
    }
    
}
