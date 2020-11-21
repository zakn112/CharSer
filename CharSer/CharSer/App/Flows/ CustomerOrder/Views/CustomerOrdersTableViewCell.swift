//
//  CustomerOrdersTableViewCell.swift
//  CharSer
//
//  Created by Андрей Закусов on 21.11.2020.
//

import UIKit

class CustomerOrdersTableViewCell: UITableViewCell {

    private let idLabel = UILabel()
    private let dateLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCustomerOrder(customerOrder: CustomerOrder){
        idLabel.text = String(customerOrder.id)
        dateLabel.text = customerOrder.date.description
    }
    
    private func setupView() {
        removeSubviews()
        setupIdLabel()
        setupDateLabel()
    }
    
    private func removeSubviews() {
        idLabel.removeFromSuperview()
        dateLabel.removeFromSuperview()
    }
    
    private func setupIdLabel() {
        addSubview(idLabel)
    }
    
    private func setupDateLabel() {
//        dateLabel.font = dateLabel.font.withSize(12)
//        dateLabel.textColor = .lightGray
        addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        idLabel.frame = CGRect(x: 0, y: 0, width: 100, height: self.bounds.size.height)
        dateLabel.frame = CGRect(x: 100, y: 0, width: self.bounds.size.width - 100, height: self.bounds.size.height)
        
    }
}
