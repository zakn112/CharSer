//
//  CustomerViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 26.10.2020.
//

import UIKit

class CustomerViewController: UIViewController {
    
    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    
    var thisObject = Customer()
    var newObject = false
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInterface()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        let fieldsСheckResult = fieldsСheck()
        
        if !fieldsСheckResult.correct {
            AlertManager.shared.showWarning(fieldsСheckResult.message)
            return
        }
        
        fillModelUsingForm()
        
        let saveResult = DataBase.shared.addObject(by: thisObject)
        
        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }
        
        onSuccess?()
    }
    
    
    private func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true
        
        if nameTextField.text == "" {
            message += "Не заполнено имя клиента \n"
            correct = false
        }
        
        return (correct: correct, message: message)
    }
    
    private func fillModelUsingForm() {
        thisObject.name = nameTextField.text ?? ""
        thisObject.phone = phoneTextField.text ?? ""
    }
    
    private func updateInterface() {
        if thisObject.id == 0 {
            idTextField.text = ""
            nameTextField.text = ""
            phoneTextField.text = ""
            
            newObject = true
        }else{
            idTextField.text = String(thisObject.id)
            nameTextField.text = thisObject.name
            phoneTextField.text = thisObject.phone
            
            newObject = false
        }
        
    }
    
}
