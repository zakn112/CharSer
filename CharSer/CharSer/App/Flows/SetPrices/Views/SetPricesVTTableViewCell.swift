//
//  SetPricesVTTableViewCell.swift
//  CharSer
//
//  Created by Андрей Закусов on 04.11.2020.
//

import UIKit

class SetPricesVTTableViewCell: UITableViewCell {

    private let weekdayTextField = UITextField()
    private let startTimeDatePicker = UIDatePicker()
    private let endTimeDatePicker = UIDatePicker()
    private let priceTextField = UITextField()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func SetPricesVTItem(vtPricesItem: VTPricesItem){
        weekdayTextField.text = String(vtPricesItem.weekday)
        startTimeDatePicker.setDate(vtPricesItem.startTime , animated: false)
        endTimeDatePicker.setDate(vtPricesItem.endTime , animated: false)
        priceTextField.text = String(vtPricesItem.price)
    }
    
    private func setupView() {
        removeSubviews()
        setupWeekdayTextField()
        setupStartTimeDatePicker()
        setupEndTimeDatePicker()
        setupPriceTextField()
    }
    
    private func removeSubviews() {
        weekdayTextField.removeFromSuperview()
        startTimeDatePicker.removeFromSuperview()
        endTimeDatePicker.removeFromSuperview()
        priceTextField.removeFromSuperview()
    }
    
    private func setupWeekdayTextField() {
        addSubview(weekdayTextField)
    }
    
    private func setupStartTimeDatePicker() {
        startTimeDatePicker.datePickerMode = .time
        addSubview(startTimeDatePicker)
    }
    
    private func setupEndTimeDatePicker() {
        endTimeDatePicker.datePickerMode = .time
        addSubview(endTimeDatePicker)
    }
    
    private func setupPriceTextField() {
        addSubview(priceTextField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let parentWidth = self.bounds.size.width
        let parentHeight = self.bounds.size.height
        
        weekdayTextField.frame = CGRect(x: 0, y: 0, width: parentWidth/4, height: parentHeight)
        
        startTimeDatePicker.frame = CGRect(x: parentWidth/4, y: 0, width: parentWidth/4 , height: parentHeight)
        endTimeDatePicker.frame = CGRect(x: 2*parentWidth/4, y: 0, width: parentWidth/4 , height: parentHeight)
        priceTextField.frame = CGRect(x: 3*parentWidth/4, y: 0, width: parentWidth/4 , height: parentHeight)
        
    }

}
