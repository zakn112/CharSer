//
//  DataBase.swift
//  CharSer
//
//  Created by Андрей Закусов on 13.10.2020.
//

import Foundation

protocol DataBaseInterface {
    
    func setConfiguration() -> ()
    
    func getObjectsList(object: ReferenceModel.Type) ->([ReferenceModel]?)
    func addObject(by object: ReferenceModel, update: Bool) -> (result: Bool, message: String)
    
    func getUsersCount() -> (Int)
    func addUser(by user: User, update: Bool, updatePassword: Bool) -> (result: Bool, message: String)
    func getUserByLogin(login: String) -> (User?)
    func login(login: String, password: String) -> (User?)
    
    func getSetPricesList() ->([SetPrices]?)
    func addSetPrices(by setPrices: SetPrices, update: Bool) -> (result: Bool, message: String)
    func getSetPricesByID(id: Int) -> (SetPrices?)
    
}

class DataBase: DataBaseInterface {
 
    static var shared: DataBaseInterface = DataBase()
    private let currentDataBase = DBCoreData()
    
    private init(){}
    
    func setConfiguration() {
        currentDataBase.setConfiguration()
    }
    
    
}

//MARK: ReferenceObjectDB

extension DataBase{
    
    func getObjectsList(object: ReferenceModel.Type) ->([ReferenceModel]?){
        return currentDataBase.getObjectsList(object: object)
    }

    func addObject(by object: ReferenceModel, update: Bool) -> (result: Bool, message: String) {
        return currentDataBase.addObject(by: object, update: update)
    }

//    func getObjectByID(id: Int) -> (ReferenceModel?) {
//        return currentDataBase.getObjectByID(id: id)
//    }

//    func getObjectsCount(object: ReferenceObjectDB) -> (Int) {
//        return currentDataBase.getObjectsCount(object: object)
//    }

    
}

//MARK: Users

extension DataBase{
    
    func getUsersCount() -> (Int) {
       return currentDataBase.getUsersCount()
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

//MARK: SetPrices

extension DataBase{
    
    func getSetPricesList() ->([SetPrices]?){
        return currentDataBase.getSetPricesList()
    }

    func addSetPrices(by setPrices: SetPrices, update: Bool) -> (result: Bool, message: String) {
        return currentDataBase.addSetPrices(by: setPrices, update: update)
    }

    func getSetPricesByID(id: Int) -> (SetPrices?) {
        return currentDataBase.getSetPricesByID(id: id)
    }

    
}



