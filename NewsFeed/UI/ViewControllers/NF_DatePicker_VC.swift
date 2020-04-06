//
//  NF_DatePicker_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 05/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func DateResponse(type: CustomDateType, date: Date)
}

class NF_DatePicker_VC: UIViewController {
    
    let view_containerView = UIView()
    let pickerView_date = UIDatePicker()
    let label_title = NF_Label_Title(fontSize: 20, fontWeight: .bold, lines: 1, textAlignment: .center)
    let button_action = NF_Button(backgroundColor: .systemRed, title: "OK", titleColor: .systemRed)
    let button_cancel = NF_Button(backgroundColor: .systemRed, title: "Cancel", titleColor: .systemRed)
    
    var delegate : DatePickerDelegate?
    var alertTitle : String?
    var customDateType : CustomDateType!
    var selectedDate : Date?
    
    var padding : CGFloat = 20
    
    init(dateType: CustomDateType, title: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.customDateType = dateType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        ConfigureContainerView()
        ConfigureTitleLabel()
        ConfigureActionButton()
        ConfigureCancelButton()
        ConfigurePickerView()
    }
    
    func ConfigureContainerView(){
        view.addSubview(view_containerView)
        view_containerView.backgroundColor = .systemBackground
        view_containerView.layer.cornerRadius = 16
        view_containerView.layer.borderWidth = 2
        view_containerView.layer.borderColor = UIColor.white.cgColor
        view_containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view_containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view_containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view_containerView.heightAnchor.constraint(equalToConstant: 300),
            view_containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func ConfigurePickerView(){
        view_containerView.addSubview(pickerView_date)
        pickerView_date.translatesAutoresizingMaskIntoConstraints = false
                
        pickerView_date.datePickerMode = .date
        pickerView_date.timeZone = .current
        pickerView_date.contentMode = .center
        pickerView_date.maximumDate = Date()
        pickerView_date.minimumDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())
        
        NSLayoutConstraint.activate([
            pickerView_date.centerXAnchor.constraint(equalTo: view_containerView.centerXAnchor),
            pickerView_date.centerYAnchor.constraint(equalTo: view_containerView.centerYAnchor, constant: -10),
            pickerView_date.widthAnchor.constraint(equalToConstant: 250),
            pickerView_date.heightAnchor.constraint(equalToConstant: 186)
        ])
    }
    
    func ConfigureTitleLabel(){
        view_containerView.addSubview(label_title)
        label_title.text = alertTitle ?? "Alert Title"
        
        NSLayoutConstraint.activate([
            label_title.topAnchor.constraint(equalTo: view_containerView.topAnchor, constant: padding),
            label_title.leadingAnchor.constraint(equalTo: view_containerView.leadingAnchor, constant: padding),
            label_title.trailingAnchor.constraint(equalTo: view_containerView.trailingAnchor, constant: -padding),
            label_title.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func ConfigureActionButton(){
        view_containerView.addSubview(button_action)
        button_action.addTarget(self, action: #selector(Btn_Action), for: .touchUpInside)
        button_action.backgroundColor = nil
        
        NSLayoutConstraint.activate([
            button_action.bottomAnchor.constraint(equalTo: view_containerView.bottomAnchor, constant: -padding),
            button_action.centerXAnchor.constraint(equalTo: view_containerView.centerXAnchor, constant: 50),
            button_action.widthAnchor.constraint(equalToConstant: 120),
            button_action.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func ConfigureCancelButton(){
        view_containerView.addSubview(button_cancel)
        button_cancel.addTarget(self, action: #selector(Btn_Cancel), for: .touchUpInside)
        button_cancel.backgroundColor = nil
        
        NSLayoutConstraint.activate([
            button_cancel.bottomAnchor.constraint(equalTo: view_containerView.bottomAnchor, constant: -padding),
            button_cancel.centerXAnchor.constraint(equalTo: view_containerView.centerXAnchor, constant: -50),
            button_cancel.widthAnchor.constraint(equalToConstant: 120),
            button_cancel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func Btn_Action(){
        dismiss(animated: true) {
            self.delegate?.DateResponse(type: self.customDateType, date: self.pickerView_date.date)
        }
    }
    
    @objc func Btn_Cancel(){
        dismiss(animated: true, completion: nil)
    }
}
