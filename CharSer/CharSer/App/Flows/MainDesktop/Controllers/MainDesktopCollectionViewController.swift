//
//  MainDesktopCollectionViewController.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.12.2020.
//

import UIKit

private let reuseIdentifier = MainDesktopCollectionViewCell.storyBoardIdentifier

class MainDesktopCollectionViewController: UICollectionViewController {

    var onMainMenu: (() -> Void)?
    var onNewOrder: ((СhargObject) -> Void)?
    var onOpenOrder: ((CustomerOrder) -> Void)?
    
    var presenter: MainDesktopViewOutput!
    
    var desktopItems = [MainDesktopItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        presenter.updateItems()
        
        // Register cell classes
        //self.collectionView.register(MainDesktopCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    func updateForm(){
        presenter.updateItems()
    }
    
    @IBAction func LeftSwype(_ sender: Any) {
        onMainMenu?()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return desktopItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let cell = cell as? MainDesktopCollectionViewCell {
            cell.mainDesktopItem = desktopItems[indexPath.row]
            cell.delegate = self
            return cell
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MainDesktopCollectionViewController: MainDesktopViewInput {
    
}

extension MainDesktopCollectionViewController: UICollectionViewDelegateFlowLayout
{
    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        var width = self.view.bounds.size.width
        let numbernHorizontally = Int(width/300)
        width = width/CGFloat(numbernHorizontally)
        return CGSize(width: width - 10, height: 160.0)
    }
}

extension MainDesktopCollectionViewController: MainDesktopCollectionViewCellDelegate {
    func newOrder(_ chargObject: СhargObject) {
        onNewOrder?(chargObject)
    }
    
    func openOrder(_ customerOrder: CustomerOrder) {
        onOpenOrder?(customerOrder)
    }
    
    
}
