//
//  ViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 12.12.2020.
//

import UIKit

extension UIViewController {
    static var storyBoardIdentifier: String { String(describing: self) }
}

protocol Storyboardable {
    var storyBoardIdentifier: String { get };
    var StoryboardName: String { get }
    
}
