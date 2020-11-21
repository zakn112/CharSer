//
//  CustomerOrderViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//

import UIKit

class CustomerOrderViewController: UIViewController {
    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    var onSelectСhargObject: ((CustomerOrderViewController) -> Void)?
    var onSelectCustomer: ((CustomerOrderViewController) -> Void)?
    
    var thisObject: CustomerOrder?
    var isNewObject = false
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var chargObjectTextField: UITextField!
    @IBOutlet weak var customerTextField: UITextField!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountPaidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = thisObject {
            //thisObject = DataBase.shared.getSetPricesByID(id: thisObject?.id ?? 0)
        }
        
        idTextField.isEnabled = false
        
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

        let saveResult = DataBase.shared.addObject(by: thisObject!, update: !isNewObject)

        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }

        onSuccess?()
    }
    
    @IBAction func makePaymentButtonPress(_ sender: Any) {
    }
    
    @IBAction func cancelOrderButtonPress(_ sender: Any) {
    }
    
    @IBAction func completOrderButtonPress(_ sender: Any) {
    }
    
    @IBAction func chargObjectTouchDown(_ sender: Any) {
        onSelectСhargObject?(self)
    }
    
    @IBAction func customerTouchDown(_ sender: Any) {
        onSelectCustomer?(self)
    }
    
    
    private func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true

        
        return (correct: correct, message: message)
    }

    private func fillModelUsingForm() {
        if thisObject == nil {
            thisObject = CustomerOrder()
        }
        
        if let thisObject = thisObject {
            thisObject.date = dateDatePicker.date
            thisObject.startDate = startTimeDatePicker.date
            thisObject.endDate = endTimeDatePicker.date
            
        }
      
    }

    func updateInterface() {
        if thisObject == nil {
            idTextField.text = ""
            dateDatePicker.setDate(Date(), animated: false)
            startTimeDatePicker.setDate(Date(), animated: false)
            endTimeDatePicker.setDate(Date(), animated: false)
            statusLabel.text = CustomerOrderStatus.new.rawValue
            amountLabel.text = "0"
            amountPaidLabel.text = "0"
            
            chargObjectTextField.text = ""
            customerTextField.text = ""
            
            thisObject = CustomerOrder()
            
        }else{
            idTextField.text = String(thisObject?.id ?? 0)
            dateDatePicker.setDate(thisObject?.date ?? Date(), animated: false)
            startTimeDatePicker.setDate(thisObject?.startDate ?? Date(), animated: false)
            endTimeDatePicker.setDate(thisObject?.endDate ?? Date(), animated: false)
            amountLabel.text = String(thisObject?.amount ?? 0)
            amountPaidLabel.text = String(thisObject?.amountPaid ?? 0)
            
            if let chargObject = self.thisObject?.chargObject {
                chargObjectTextField.text = chargObject.name
            }
            
            if let customer = self.thisObject?.customer {
                customerTextField.text = customer.name
            }

        }
        
        isNewObject = (thisObject?.id ?? 0) == 0

       }
}

