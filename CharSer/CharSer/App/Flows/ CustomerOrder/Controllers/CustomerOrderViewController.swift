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
    var onPaymentForm: ((CustomerOrderViewController) -> Void)?
    
    var thisObject = CustomerOrder()
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
        
        idTextField.isEnabled = false
        
        //        startTimeDatePicker.timeZone = TimeZone.init(identifier: "UTC")
        //        endTimeDatePicker.timeZone = TimeZone.init(identifier: "UTC")
        
        updateInterface()
        // Do any additional setup after loading the view.
        
        //перенести в модельвью
        durationLabel.text = TariffCalculation.shared.durationTimeIntervalString(start: startTimeDatePicker.date, end: endTimeDatePicker.date)
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        let fieldsСheckResult = fieldsСheck()
        
        if !fieldsСheckResult.correct {
            AlertManager.shared.showWarning(fieldsСheckResult.message)
            return
        }
        
        fillModelUsingForm()
        
        let saveResult = DataBase.shared.addObject(by: thisObject, update: !isNewObject)
        
        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }
        
        onSuccess?()
    }
    
    @IBAction func makePaymentButtonPress(_ sender: Any) {
        onPaymentForm?(self)
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
    
    @IBAction func startTimeValueChanged(_ sender: Any) {
        //перенести во вьюмодель
        durationLabel.text = TariffCalculation.shared.durationTimeIntervalString(start: startTimeDatePicker.date, end: endTimeDatePicker.date)
        thisObject.amount = TariffCalculation.shared.ammuntTimeInterval(start: startTimeDatePicker.date, end: endTimeDatePicker.date)
        amountLabel.text = String(format: "%.2f", TariffCalculation.shared.ammuntTimeInterval(start: startTimeDatePicker.date, end: endTimeDatePicker.date))
    }
    
    @IBAction func endTimeValueChanged(_ sender: Any) {
        //перенести во вьюмодель
        durationLabel.text = TariffCalculation.shared.durationTimeIntervalString(start: startTimeDatePicker.date, end: endTimeDatePicker.date)
        thisObject.amount = TariffCalculation.shared.ammuntTimeInterval(start: startTimeDatePicker.date, end: endTimeDatePicker.date)
        amountLabel.text = String(TariffCalculation.shared.ammuntTimeInterval(start: startTimeDatePicker.date, end: endTimeDatePicker.date))
    }
    
    private func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true
        
        
        return (correct: correct, message: message)
    }
    
    private func fillModelUsingForm() {
        
        thisObject.date = dateDatePicker.date
        thisObject.startDate = startTimeDatePicker.date
        thisObject.endDate = endTimeDatePicker.date
        
    }
    
    func updateInterface() {
        if thisObject.id == 0 {
            idTextField.text = ""
            dateDatePicker.setDate(Date(), animated: false)
            startTimeDatePicker.setDate(Date(), animated: false)
            endTimeDatePicker.setDate(Date(), animated: false)
            statusLabel.text = CustomerOrderStatus.new.rawValue
            amountLabel.text = "0"
            amountPaidLabel.text = "0"
            
            chargObjectTextField.text = ""
            customerTextField.text = ""
            
        }else{
            
            
            idTextField.text = String(thisObject.id)
            dateDatePicker.setDate(thisObject.date, animated: false)
            startTimeDatePicker.setDate(thisObject.startDate, animated: false)
            endTimeDatePicker.setDate(thisObject.endDate, animated: false)
            amountLabel.text = String(thisObject.amount)
            amountPaidLabel.text = String(thisObject.amountPaid)
            
            if let chargObject = self.thisObject.chargObject {
                chargObjectTextField.text = chargObject.name
            }
            
            if let customer = self.thisObject.customer {
                customerTextField.text = customer.name
            }
        }
        
        isNewObject = (thisObject.id ?? 0) == 0
        
    }
    
    func addPayment(_ sum: Double){
        thisObject.amountPaid += sum
        updateInterface()
    }
}

