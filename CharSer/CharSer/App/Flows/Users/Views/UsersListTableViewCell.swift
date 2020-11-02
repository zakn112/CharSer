//
//  UsersListTableViewCell.swift
//  CharSer
//
//  Created by Андрей Закусов on 18.10.2020.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {
    
    private let userNameLabel = UILabel()
    private let userRoleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUser(user: User){
        userNameLabel.text = "\(user.firstName) \(user.lastName)"
        userRoleLabel.text = user.role.rawValue
    }
    
    private func setupView() {
        removeSubviews()
        setupUserNameLabel()
        setupUserRoleLabel()
    }
    
    private func removeSubviews() {
        userNameLabel.removeFromSuperview()
        userRoleLabel.removeFromSuperview()
    }
    
    private func setupUserNameLabel() {
        addSubview(userNameLabel)
    }
    
    private func setupUserRoleLabel() {
        userRoleLabel.font = userRoleLabel.font.withSize(12)
        userRoleLabel.textColor = .lightGray
        addSubview(userRoleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userNameLabel.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 10, height: round(self.bounds.size.height/3*2))
        userRoleLabel.frame = CGRect(x: 20, y: round(self.bounds.size.height/3*2), width: self.bounds.size.width - 20, height: round(self.bounds.size.height/3))
        
    }
}
