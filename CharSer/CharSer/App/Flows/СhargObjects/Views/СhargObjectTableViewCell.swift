//
//  СhargObjectTableViewCell.swift
//  CharSer
//
//  Created by Андрей Закусов on 31.10.2020.
//

import UIKit

class ChargObjectTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    //private let phoneLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setСhargObject(chargObject: СhargObject){
        nameLabel.text = chargObject.name
       // phoneLabel.text = customer.phone
    }
    
    private func setupView() {
        removeSubviews()
        setupUserNameLabel()
        setupUserRoleLabel()
    }
    
    private func removeSubviews() {
        nameLabel.removeFromSuperview()
        //phoneLabel.removeFromSuperview()
    }
    
    private func setupUserNameLabel() {
        addSubview(nameLabel)
    }
    
    private func setupUserRoleLabel() {
//        phoneLabel.font = phoneLabel.font.withSize(12)
//        phoneLabel.textColor = .lightGray
//        addSubview(phoneLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 10, height: round(self.bounds.size.height/3*2))
//        phoneLabel.frame = CGRect(x: 20, y: round(self.bounds.size.height/3*2), width: self.bounds.size.width - 20, height: round(self.bounds.size.height/3))
        
    }

}
