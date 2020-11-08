//
//  SetPricesTableViewCell.swift
//  CharSer
//
//  Created by Андрей Закусов on 04.11.2020.
//

import UIKit

class SetPricesTableViewCell: UITableViewCell {

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

    func setSetPrices(setPrices: SetPrices){
        idLabel.text = String(setPrices.id)
        dateLabel.text = setPrices.date.description
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
