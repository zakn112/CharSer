//
//  CustomerOrderViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//

import UIKit

class CustomerOrderViewController: UIViewController {
    var onFinishFlow: (() -> Void)?
    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    var onSelectСhargObject: ((CustomerOrderViewController) -> Void)?
    var onSelectCustomer: ((CustomerOrderViewController) -> Void)?
    var onPaymentForm: ((CustomerOrderViewController) -> Void)?
    
    var thisObject = CustomerOrder()
    
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
    
    var presenter: CustomerOrderViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        updateInterface()
        
        idTextField.isEnabled = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let _ = self.navigationController?.viewControllers.firstIndex(of: self) {
            
        }else{
            onFinishFlow?()
        }
        
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        fillModelUsingForm()
        presenter.saveCustomerOrder()
    }
    
    @IBAction func makePaymentButtonPress(_ sender: Any) {
        onPaymentForm?(self)
    }
    
    @IBAction func cancelOrderButtonPress(_ sender: Any) {
        presenter.cancelOrder()
    }
    
    @IBAction func completOrderButtonPress(_ sender: Any) {
        presenter.completOrder()
    }
    
    @IBAction func chargObjectTouchDown(_ sender: Any) {
        onSelectСhargObject?(self)
    }
    
    @IBAction func customerTouchDown(_ sender: Any) {
        onSelectCustomer?(self)
    }
    
    @IBAction func startTimeValueChanged(_ sender: Any) {
        thisObject.startDate = startTimeDatePicker.date
      
        presenter.startTimeValueChanged()
      
        updateInterface()
    }
    
    @IBAction func endTimeValueChanged(_ sender: Any) {
        thisObject.endDate = endTimeDatePicker.date
        
        presenter.endTimeValueChanged()
      
        updateInterface()
    }
    
   
    
    private func fillModelUsingForm() {
        
        thisObject.date = dateDatePicker.date
        thisObject.startDate = startTimeDatePicker.date
        thisObject.endDate = endTimeDatePicker.date
        
    }
    
    func updateInterface() {
        
        idTextField.text = String(thisObject.id)
        statusLabel.text = thisObject.status.rawValue
        dateDatePicker.setDate(thisObject.date, animated: false)
        startTimeDatePicker.setDate(thisObject.startDate, animated: false)
        endTimeDatePicker.setDate(thisObject.endDate, animated: false)
        amountLabel.text = String(thisObject.amount)
        amountPaidLabel.text = String(thisObject.amountPaid)
        durationLabel.text = thisObject.durationText
        amountLabel.text = String(format: "%.2f", thisObject.amount)
        
        if let chargObject = self.thisObject.chargObject {
            chargObjectTextField.text = chargObject.name
        }
        
        if let customer = self.thisObject.customer {
            customerTextField.text = customer.name
        }
        
    }
    
   
}

// MARK: - Input

extension CustomerOrderViewController: CustomerOrderViewInput {
    
    func saveSuccess(){
        onSuccess?()
    }
    
}

