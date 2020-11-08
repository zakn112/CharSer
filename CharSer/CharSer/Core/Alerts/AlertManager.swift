//
//  AlertManager.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.11.2020.
//

import Foundation
import UIKit

class AlertManager{
    static let shared = AlertManager()
    
    private init(){
        
    }
    
    func showWarning(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        if let presentingViewController = sceneDelegate?.window?.rootViewController?.presentingViewController {
           presentingViewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
