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
    func createUser(by user: User) -> (result: Bool, message: String)
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
    
    func getUsetsCount() -> (Int) {
       return currentDataBase.getUsetsCount()
    }
    
    func createUser(by user: User) -> (result: Bool, message: String) {
       return currentDataBase.createUser(by: user)
    }
    
    func getUserByLogin(login: String) -> (User?) {
        return currentDataBase.getUserByLogin(login: login)
    }
    
    func login(login: String, password: String) -> (User?) {
       return currentDataBase.login(login: login, password: password)
    }
}
