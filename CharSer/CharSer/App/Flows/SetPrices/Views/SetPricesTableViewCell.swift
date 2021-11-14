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
    private let chargObjectLabel = UILabel()
    private let formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        formatter.dateFormat = "dd.MM.yy HH:mm"
        
        setupView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setSetPrices(setPrices: SetPrices){
        idLabel.text = String(setPrices.id)
        dateLabel.text = formatter.string(from: setPrices.date as Date)
        chargObjectLabel.text = setPrices.chargObject?.name
    }
    
    private func setupView() {
        removeSubviews()
        setupIdLabel()
        setupDateLabel()
        setupChargObjectLabel()
    }
    
    private func removeSubviews() {
        idLabel.removeFromSuperview()
        dateLabel.removeFromSuperview()
        chargObjectLabel.removeFromSuperview()
    }
    
    private func setupIdLabel() {
        addSubview(idLabel)
    }
    
    private func setupDateLabel() {
//        dateLabel.font = dateLabel.font.withSize(12)
//        dateLabel.textColor = .lightGray
        addSubview(dateLabel)
    }
    
    private func setupChargObjectLabel() {
        addSubview(chargObjectLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        idLabel.frame = CGRect(x: 0, y: 0, width: 50, height: self.bounds.size.height)
        dateLabel.frame = CGRect(x: 50, y: 0, width: 150, height: self.bounds.size.height)
        chargObjectLabel.frame = CGRect(x: 200, y: 0, width: self.bounds.size.width - 200, height: self.bounds.size.height)
        
    }
}
