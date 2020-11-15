//
//  SetPricesViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 04.11.2020.
//

import UIKit

class SetPricesViewController: UIViewController {
    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    var onSelectСhargObject: ((SetPricesViewController) -> Void)?
    
    var thisObject: SetPrices?
    var newObject = false
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var chargObjectTextField: UITextField!
    @IBOutlet weak var pricesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = thisObject {
            thisObject = DataBase.shared.getSetPricesByID(id: thisObject?.id ?? 0)
        }
        
        idTextField.isEnabled = false
        
        pricesTableView.delegate = self
        pricesTableView.dataSource = self

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

        let saveResult = DataBase.shared.addSetPrices(by: thisObject!, update: !newObject)

        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }

        onSuccess?()
    }
    
    
    @IBAction func addVTItemButtonPress(_ sender: Any) {
        if thisObject == nil {
            thisObject = SetPrices()
        }
        
        if let thisObject = thisObject {
            thisObject.vtPrices.append(VTPricesItem())
        }
        
        pricesTableView.reloadData()
        
    }
    
    @IBAction func chargObjectTouchDown(_ sender: Any) {
        onSelectСhargObject?(self)
    }
    
    
    private func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true

        
        return (correct: correct, message: message)
    }

    private func fillModelUsingForm() {
        if thisObject == nil {
            thisObject = SetPrices()
        }

        if let thisObject = thisObject {
            thisObject.date = dateDatePicker.date
            //thisObject.phone = phoneTextField.text ?? ""
        }
      
    }

    func updateInterface() {
        if thisObject == nil {
            idTextField.text = ""
            dateDatePicker.setDate(Date(), animated: false)
           
            newObject = true
        }else{
            idTextField.text = String(thisObject?.id ?? 0)
            dateDatePicker.setDate(thisObject?.date ?? Date(), animated: false)
            
            if let chargObject = self.thisObject?.chargObject {
                chargObjectTextField.text = chargObject.name
            }

            newObject = false
        }

       }
}


extension SetPricesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return thisObject?.vtPrices.count ?? 0
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pricesVTItem", for: indexPath) as? SetPricesVTTableViewCell,
           let vtPrices = thisObject?.vtPrices {
            cell.SetPricesVTItem(vtPricesItem: vtPrices[indexPath.row])
            return cell
        }
        
        return CustomerListTableViewCell()
    }
    
    
}
