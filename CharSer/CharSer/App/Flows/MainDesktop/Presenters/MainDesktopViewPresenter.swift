//
//  MainDesktopViewPresenter.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.12.2020.
//

import Foundation
import UIKit

protocol MainDesktopViewInput {
    var desktopItems: [MainDesktopItem] { get set }
    
}

protocol MainDesktopViewOutput {
   func updateItems()
}

class MainDesktopViewPresenter {
   weak var viewInput: (UICollectionViewController & MainDesktopViewInput)?
    
   
}


extension MainDesktopViewPresenter: MainDesktopViewOutput {
    func updateItems() {
        guard let _ = viewInput else { return }
        
        viewInput?.desktopItems = DataBase.shared.getMainDesktopItems() ?? [MainDesktopItem]()
    }
    
    
    
}
