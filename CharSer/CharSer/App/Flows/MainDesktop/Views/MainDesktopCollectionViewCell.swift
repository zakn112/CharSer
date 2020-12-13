//
//  MainDesktopCollectionViewCell.swift
//  CharSer
//
//  Created by Андрей Закусов on 05.12.2020.
//

import UIKit

protocol MainDesktopCollectionViewCellDelegate {
    func newOrder(_ chargObject: СhargObject)
    func openOrder(_ customerOrder: CustomerOrder)
}

class MainDesktopCollectionViewCell: UICollectionViewCell {
    
    var mainDesktopItem = MainDesktopItem() {
        didSet{
            updateView()
        }
    }
    
    private let chargObjectNameLabel = UILabel()
    private let customerNameLabel = UILabel()
    private let startEndTimeLabel = UILabel()
    private let durationLabel = UILabel()
    private let ammountLabel = UILabel()
    private let ammountPaidLabel = UILabel()
    
    private let newOrderButton = UIButton()
    private let currentOrderButton = UIButton()
    
    private let leftView = UIView()
    private let rightView = UIView()
    
    
    private let dateLabel = UILabel()
    
    var delegate: MainDesktopCollectionViewCellDelegate?
    
    func updateView() {
        chargObjectNameLabel.text = mainDesktopItem.chargObject.name
        if mainDesktopItem.customerOrder.id == 0 {
            customerNameLabel.text = "Гость: --"
            startEndTimeLabel.text = "C -- по --"
            
            durationLabel.text = "Длительность: --"
            ammountLabel.text = "Сумма: -- руб."
            ammountPaidLabel.text = "Оплачено: -- руб."
        }else{
            customerNameLabel.text = mainDesktopItem.customerOrder.customer.flatMap { "Гость: \($0.name)" }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM HH:mm"
            let startDate = formatter.string(from: mainDesktopItem.customerOrder.startDate as Date)
            let endDate = formatter.string(from: mainDesktopItem.customerOrder.endDate as Date)
            startEndTimeLabel.text = "C \(startDate) по \(endDate)"
            
            durationLabel.text = "Длительность: \(mainDesktopItem.customerOrder.durationText)"
            ammountLabel.text = "Сумма: \(mainDesktopItem.customerOrder.amount) руб."
            ammountPaidLabel.text = "Оплачено: \(mainDesktopItem.customerOrder.amountPaid) руб."
        }
        
        
        newOrderButton.setTitle("Новый", for: .normal)
        currentOrderButton.setTitle("Открыть", for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .systemGray4
        
        setupView()
       
    }

    private func setupView() {
        removeSubviews()
        setupLeftView()
        setupRightView()
    }
    
    private func removeSubviews() {
        leftView.removeFromSuperview()
        rightView.removeFromSuperview()
    }
    
    private func setupLeftView() {
        addSubview(leftView)
        
        setupChargObjectNameLabel(leftView)
        setupCustomerNameLabel(leftView)
        setupStartEndTimeLabel(leftView)
        setupDurationLabel(leftView)
        setupAmmountLabel(leftView)
        setupAmmountPaidLabel(leftView)
    }
    
    private func setupRightView() {
        addSubview(rightView)
        setupNewOrderButton(rightView)
        setupCurrentOrderButton(rightView)
    }
    
    private func setupChargObjectNameLabel(_ parentView: UIView) {
        chargObjectNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        chargObjectNameLabel.textColor = .blue
        parentView.addSubview(chargObjectNameLabel)
    }
    
    private func setupCustomerNameLabel(_ parentView: UIView) {
        parentView.addSubview(customerNameLabel)
    }
    
    private func setupStartEndTimeLabel(_ parentView: UIView) {
        startEndTimeLabel.font = UIFont.systemFont(ofSize: 14)
        parentView.addSubview(startEndTimeLabel)
    }
    
    private func setupDurationLabel(_ parentView: UIView) {
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        parentView.addSubview(durationLabel)
    }
    
    private func setupAmmountLabel(_ parentView: UIView) {
        parentView.addSubview(ammountLabel)
    }
    
    private func setupAmmountPaidLabel(_ parentView: UIView) {
        ammountPaidLabel.font = UIFont.systemFont(ofSize: 14)
        parentView.addSubview(ammountPaidLabel)
    }
    
    private func setupNewOrderButton(_ parentView: UIView) {
        newOrderButton.addTarget(self, action: #selector(self.newOrderButtonPress), for: UIButton.Event.touchDown)
        
        newOrderButton.backgroundColor = .white
        newOrderButton.setTitleColor(.blue, for: .normal)
        parentView.addSubview(newOrderButton)
    }
    
    private func setupCurrentOrderButton(_ parentView: UIView) {
        
        currentOrderButton.addTarget(self, action: #selector(self.currentOrderButtonPress), for: UIButton.Event.touchDown)
        
        currentOrderButton.backgroundColor = .white
        currentOrderButton.setTitleColor(.black, for: .normal)
        parentView.addSubview(currentOrderButton)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftViewWidth = round(self.bounds.size.width * 0.7)
        let rightViewWidth = round(self.bounds.size.width * 0.3)
        leftView.frame = CGRect(x: 0, y: 0, width: leftViewWidth , height: self.bounds.size.height)
        rightView.frame = CGRect(x: leftViewWidth , y: 0, width: rightViewWidth, height: self.bounds.size.height)
        
        var currentY:CGFloat = 10
        var currentHeight:CGFloat = 20
        let margin:CGFloat = 5
        
        chargObjectNameLabel.frame = CGRect(x: 20, y: currentY, width: leftViewWidth - 30, height: currentHeight)
        
        currentY += (margin + currentHeight)
        currentHeight = 20
        
        customerNameLabel.frame = CGRect(x: 20, y: currentY, width: leftViewWidth - 30, height: currentHeight)
        
        currentY += (margin + currentHeight)
        currentHeight = 15
        
        startEndTimeLabel.frame = CGRect(x: 20, y: currentY, width: leftViewWidth - 30, height: currentHeight)
        
        currentY += (margin + currentHeight)
        currentHeight = 15
        
        durationLabel.frame = CGRect(x: 20, y: currentY, width: leftViewWidth - 30, height: currentHeight)
        
        currentY += (margin + currentHeight)
        currentHeight = 20
        
        ammountLabel.frame = CGRect(x: 20, y: currentY, width: leftViewWidth - 30, height: currentHeight)
        
        currentY += (margin + currentHeight)
        currentHeight = 15
        
        ammountPaidLabel.frame = CGRect(x: 20, y: currentY, width: leftViewWidth - 30, height: currentHeight)
        
        //rightView
        currentY = margin
        currentHeight = 30
        
        newOrderButton.frame = CGRect(x: 10, y: currentY, width: rightViewWidth - 20, height: currentHeight)
        
        currentY += (margin + currentHeight)
        currentHeight = 30
        
        currentOrderButton.frame = CGRect(x: 10, y: currentY, width: rightViewWidth - 20, height: currentHeight)
        
    }
    
    @objc private func currentOrderButtonPress() {
        if mainDesktopItem.customerOrder.id != 0 {
            delegate?.openOrder(mainDesktopItem.customerOrder)
        }
    }
    
    @objc private func newOrderButtonPress() {
        delegate?.newOrder(mainDesktopItem.chargObject)
    }
    
}
