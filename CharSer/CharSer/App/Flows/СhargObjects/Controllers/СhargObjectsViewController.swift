//
//  СhargObjectsViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import UIKit

class ChargObjectsViewController: UIViewController {
    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    
    var thisObject = СhargObject()
    var newObject = false
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var shutdownTimeDatePicker: UIDatePicker!
    
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

        let saveResult = DataBase.shared.addObject(by: thisObject, update: !newObject)

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
            thisObject.startTime = startTimeDatePicker.date
            thisObject.shutdownTime = shutdownTimeDatePicker.date
       
    }

    private func updateInterface() {
        if thisObject.id == 0 {
            idTextField.text = ""
            nameTextField.text = ""
            startTimeDatePicker.date = Date(timeIntervalSince1970: 0)
            shutdownTimeDatePicker.date = Date(timeIntervalSince1970: 0)

            newObject = true
        }else{
            idTextField.text = String(thisObject.id)
            nameTextField.text = thisObject.name
            startTimeDatePicker.date = thisObject.startTime
            shutdownTimeDatePicker.date = thisObject.shutdownTime

            newObject = false
        }

       }

}
