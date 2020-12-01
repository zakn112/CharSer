//
//  CustomerOrderViewPresenter.swift
//  CharSer
//
//  Created by Андрей Закусов on 01.12.2020.
//

import Foundation
import UIKit

protocol CustomerOrderViewInput {
    var thisObject: CustomerOrder {get set}
    
    func saveSuccess()
    func updateInterface()
    
    
}

protocol CustomerOrderViewOutput {
    func saveCustomerOrder()
    func startTimeValueChanged()
    func endTimeValueChanged()
    func addPayment(_ sum: Double)
    func cancelOrder()
    func completOrder()
}

class CustomerOrderViewPresenter {
   weak var viewInput: (UIViewController & CustomerOrderViewInput)?
    
    private func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true
        
        
        return (correct: correct, message: message)
    }
   
}


extension CustomerOrderViewPresenter: CustomerOrderViewOutput {
    
    func saveCustomerOrder(){
        
        guard let viewInput = viewInput else { return }
        
        let fieldsСheckResult = self.fieldsСheck()
        
        if !fieldsСheckResult.correct {
            AlertManager.shared.showWarning(fieldsСheckResult.message)
            return
        }
        
        let saveResult = DataBase.shared.addObject(by: viewInput.thisObject)
        
        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }
        
        viewInput.saveSuccess()
    }
    
    func startTimeValueChanged(){
        guard let viewInput = viewInput else { return }
        
        viewInput.thisObject.amount = TariffCalculation.shared.ammuntTimeInterval(start: viewInput.thisObject.startDate, end: viewInput.thisObject.endDate)
    }
    
    func endTimeValueChanged(){
        guard let viewInput = viewInput else { return }
        
        viewInput.thisObject.amount = TariffCalculation.shared.ammuntTimeInterval(start: viewInput.thisObject.startDate, end: viewInput.thisObject.endDate)
    }
    
    func addPayment(_ sum: Double){
        guard let viewInput = viewInput else { return }
        
        viewInput.thisObject.amountPaid += sum
        viewInput.updateInterface()
    }
    
    func cancelOrder(){
        guard let viewInput = viewInput else { return }
        
        viewInput.thisObject.status = .cancelled
        
        saveCustomerOrder()
        
    }
    
    func completOrder(){
        guard let viewInput = viewInput else { return }
        
        viewInput.thisObject.status = .completed
        
        saveCustomerOrder()
        
    }
    
}


