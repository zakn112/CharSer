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
    
    var vtPricesItem: VTPricesItem?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func SetPricesVTItem(vtPricesItem: VTPricesItem){
        self.vtPricesItem = vtPricesItem
        
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
        weekdayTextField.addTarget(self, action: #selector(self.weekdayTextFieldEditingDidEnd), for: UIControl.Event.editingDidEnd)
        addSubview(weekdayTextField)
    }
    
    private func setupStartTimeDatePicker() {
        startTimeDatePicker.datePickerMode = .time
        startTimeDatePicker.timeZone = TimeZone.init(identifier: "UTC")
        startTimeDatePicker.addTarget(self, action: #selector(self.startTimeDatePickerEditingDidEnd), for: UIControl.Event.editingDidEnd)
        addSubview(startTimeDatePicker)
    }
    
    private func setupEndTimeDatePicker() {
        endTimeDatePicker.datePickerMode = .time
        endTimeDatePicker.timeZone = TimeZone.init(identifier: "UTC")
        endTimeDatePicker.addTarget(self, action: #selector(self.endTimeDatePickerEditingDidEnd), for: UIControl.Event.editingDidEnd)
        addSubview(endTimeDatePicker)
    }
    
    private func setupPriceTextField() {
        priceTextField.addTarget(self, action: #selector(self.priceTextFieldEditingDidEnd), for: UIControl.Event.editingDidEnd)
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
    
    
    @objc private func weekdayTextFieldEditingDidEnd() {
        guard let _ = self.vtPricesItem else {
            return
        }
        
        self.vtPricesItem?.weekday = Int16(weekdayTextField.text ?? "0") ?? 0

    }
    
    @objc private func startTimeDatePickerEditingDidEnd() {
        guard let _ = self.vtPricesItem else {
            return
        }
        
        self.vtPricesItem?.startTime = startTimeDatePicker.date

    }
    
    @objc private func endTimeDatePickerEditingDidEnd() {
        guard let _ = self.vtPricesItem else {
            return
        }
        
        self.vtPricesItem?.endTime = endTimeDatePicker.date

    }
    
    @objc private func priceTextFieldEditingDidEnd() {
        guard let _ = self.vtPricesItem else {
            return
        }
        
        self.vtPricesItem?.price = Double(priceTextField.text ?? "0") ?? 0

    }

}
