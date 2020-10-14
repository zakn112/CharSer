//
//  UserViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 13.10.2020.
//

import UIKit

class UserViewController: UIViewController {

    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    
    var user: User?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Session.shared.firstRun {
            roleSegmentedControl.selectedSegmentIndex = 1
            roleSegmentedControl.isEnabled = false
        }
    }
    

    @IBAction func saveButtonPress(_ sender: Any) {
        let fieldsСheckResult = fieldsСheck()
        
        if !fieldsСheckResult.correct {
            let alert = UIAlertController(title: "Error", message: fieldsСheckResult.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        fillModelUsingForm()
        
        let saveResult = DataBase.shared.createUser(by: user!)
        
        if !saveResult.result {
            let alert = UIAlertController(title: "Error", message: saveResult.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        Session.shared.currenUser = user
        
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
    func fieldsСheck() -> (correct: Bool, message: String) {
        var message = ""
        var correct = true
        
        if firstNameTextField.text == "" {
            message += "Не заполнено имя пользователя \n"
            correct = false
        }
        
        if loginTextField.text == "" {
            message += "Не заполнен логин пользователя \n"
            correct = false
        }
        
        if passwordTextField.text == "" {
            message += "Не заполнен пароль пользователя \n"
            correct = false
        }
        
        return (correct: correct, message: message)
    }
    
    func fillModelUsingForm() {
        if user == nil {
            user = User()
        }
       
        if let user = user {
            user.first_name = firstNameTextField.text ?? ""
            user.last_name = lastNameTextField.text ?? ""
            user.login = loginTextField.text ?? ""
            user.password = passwordTextField.text ?? ""
            
            if roleSegmentedControl.selectedSegmentIndex == 0 {
                user.role = .user
            }else if roleSegmentedControl.selectedSegmentIndex == 1 {
                user.role = .admin
            }
        }
        
    }

}
