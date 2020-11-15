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
    var newUser = false
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInterface()
        
        if Session.shared.firstRun {
            roleSegmentedControl.selectedSegmentIndex = 1
            roleSegmentedControl.isEnabled = false
        }
    }
    

    @IBAction func saveButtonPress(_ sender: Any) {
        let fieldsСheckResult = fieldsСheck()
        
        if !fieldsСheckResult.correct {
            AlertManager.shared.showWarning(fieldsСheckResult.message)
            return
        }
        
        fillModelUsingForm()
      
        let updatePassword = newUser || user?.password != ""
        let saveResult = DataBase.shared.addUser(by: user!,update: !newUser, updatePassword: updatePassword)
        
        if !(saveResult.result) {
            AlertManager.shared.showWarning(saveResult.message)
            return
        }
        
        if Session.shared.firstRun {
            Session.shared.currenUser = user
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
        
        if firstNameTextField.text == "" {
            message += "Не заполнено имя пользователя \n"
            correct = false
        }
        
        if loginTextField.text == "" {
            message += "Не заполнен логин пользователя \n"
            correct = false
        }
        
        if passwordTextField.text == "", user == nil {
            message += "Не заполнен пароль пользователя \n"
            correct = false
        }
        
        return (correct: correct, message: message)
    }
    
    private func fillModelUsingForm() {
        if user == nil {
            user = User()
        }
       
        if let user = user {
            user.firstName = firstNameTextField.text ?? ""
            user.lastName = lastNameTextField.text ?? ""
            user.login = loginTextField.text ?? ""
            user.password = passwordTextField.text ?? ""
            
            if roleSegmentedControl.selectedSegmentIndex == 0 {
                user.role = .user
            }else if roleSegmentedControl.selectedSegmentIndex == 1 {
                user.role = .admin
            }
        }
        
    }
    
    private func updateInterface() {
        if user == nil {
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            loginTextField.text = ""
            passwordTextField.text = ""
            
            newUser = true
        }else{
            firstNameTextField.text = user?.firstName
            lastNameTextField.text = user?.lastName
            loginTextField.text = user?.login
            passwordTextField.text = ""
            loginTextField.isEnabled = false
            newUser = false
        }
        
       }

}
