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
    
    var thisObject = SetPrices()
    var newObject = false
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var chargObjectTextField: UITextField!
    @IBOutlet weak var pricesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
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

        let saveResult = DataBase.shared.addSetPrices(by: thisObject, update: !newObject)

        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }

        onSuccess?()
    }
    
    
    @IBAction func addVTItemButtonPress(_ sender: Any) {
        
       thisObject.vtPrices.append(VTPricesItem())
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
       thisObject.date = dateDatePicker.date
    }

    func updateInterface() {
        if thisObject.id == 0 {
            idTextField.text = ""
            dateDatePicker.setDate(Date(), animated: false)
            
            newObject = true
        }else{
         
            idTextField.text = String(thisObject.id)
            dateDatePicker.setDate(thisObject.date, animated: false)
            
            if let chargObject = thisObject.chargObject {
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
        return thisObject.vtPrices.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SetPricesVTTableViewCell.storyBoardIdentifier, for: indexPath) as? SetPricesVTTableViewCell{
            cell.SetPricesVTItem(vtPricesItem: thisObject.vtPrices[indexPath.row])
            return cell
        }
        
        return CustomerListTableViewCell()
    }
    
    
}
