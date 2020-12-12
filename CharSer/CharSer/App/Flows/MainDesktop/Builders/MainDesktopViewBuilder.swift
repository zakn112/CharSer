//
//  MainDesktopViewBuilder.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.12.2020.
//

import Foundation
import UIKit

final class MainDesktopViewBuilder {

    static func build() -> (MainDesktopCollectionViewController & MainDesktopViewInput) {
        let controller = UIStoryboard(name: StoryboardsNames.mainDesktop.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: MainDesktopCollectionViewController.storyBoardIdentifier ) as! MainDesktopCollectionViewController
        
        let presenter = MainDesktopViewPresenter()
        
        controller.presenter = presenter
        
        presenter.viewInput = controller
        
        return controller
    }
}
