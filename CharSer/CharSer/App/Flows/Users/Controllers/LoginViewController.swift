//
//  LoginViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 14.10.2020.
//

import UIKit

class LoginViewController: UIViewController {
    var onCansel: (() -> Void)?
    var onSuccess: (() -> Void)?
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonPress(_ sender: Any) {
        let fieldsСheckResult = fieldsСheck()
        
        if !fieldsСheckResult.correct {
            let alert = UIAlertController(title: "Error", message: fieldsСheckResult.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if let user = DataBase.shared.login(login: loginTextField.text!, password: passwordTextField.text!) {
            Session.shared.currenUser = user
            onSuccess?()
            return
        }else{
            let alert = UIAlertController(title: "Error", message: "Не правильная пара Логин - пароль. Авторизация не выполнена", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
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
}
