//
//  PaymentFormViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 28.11.2020.
//

import UIKit

class PaymentFormViewController: UIViewController {

    var onPay: ((Double?) -> Void)?
    var amountToBePaid: Double = 0
    
    @IBOutlet weak var amountToBePaidTextField: UITextField!
    @IBOutlet weak var amountOfPaymentTextField: UITextField!
    @IBOutlet weak var changeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amountToBePaidTextField.text = String(amountToBePaid)
        amountToBePaidTextField.isEnabled = false
        changeTextField.isEnabled = false
        changeTextField.text = "0"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func amountOfPaymentEditing(_ sender: Any) {
        let amountOfPayment = Double(amountOfPaymentTextField.text ?? "0") ?? 0
        if amountToBePaid < amountOfPayment {
            changeTextField.text = String(amountOfPayment - amountToBePaid)
        }else{
            changeTextField.text = "0"
        }
    }
    
    @IBAction func payButtonPress(_ sender: Any) {
        let fieldsСheckResult = fieldsСheck()

        if !fieldsСheckResult.correct {
            AlertManager.shared.showWarning(fieldsСheckResult.message)
            return
        }
        
        var amountOfPayment = Double(amountOfPaymentTextField.text ?? "0") ?? 0
        if amountToBePaid < amountOfPayment {
            amountOfPayment = amountToBePaid
        }
        
        onPay?(amountOfPayment)
    }
    
    private func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true

        if amountOfPaymentTextField.text == "" {
            message += "Укажите сумму оплаты \n"
            correct = false
        }

        return (correct: correct, message: message)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
