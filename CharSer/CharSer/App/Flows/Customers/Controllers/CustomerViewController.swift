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
    
    var thisObject: Customer?
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
      
        let saveResult = DataBase.shared.addObject(by: thisObject!, update: !newObject)
        
        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }
        
        onSuccess?()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Private implementation
    
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
        if thisObject == nil {
            thisObject = Customer()
        }
       
        if let thisObject = thisObject {
            thisObject.name = nameTextField.text ?? ""
            thisObject.phone = phoneTextField.text ?? ""
        }
        
    }
    
    private func updateInterface() {
        if thisObject == nil {
            idTextField.text = ""
            nameTextField.text = ""
            phoneTextField.text = ""
            
            newObject = true
        }else{
            idTextField.text = String(thisObject?.id ?? 0)
            nameTextField.text = thisObject?.name
            phoneTextField.text = thisObject?.phone
        
            newObject = false
        }
        
       }

}
