//
//  NF_SelectOption_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 04/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_SelectOption_VC: UIViewController {
    
    let view_containerView = UIView()
    let pickerView_selection = UIPickerView()
    let label_title = NF_Label_Title(fontSize: 20, fontWeight: .bold, lines: 1, textAlignment: .center)
    let button_action = NF_Button(backgroundColor: .systemRed, title: "OK", titleColor: .systemRed)
    let button_cancel = NF_Button(backgroundColor: .systemRed, title: "Cancel", titleColor: .systemRed)
    
    var alertTitle : String?
    var selectedOption = ""
    var selectionListCode = ["ar", "de", "en", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "se", "ud", "zh"]
    var selectionList = ["ar", "de", "en", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "se", "ud", "zh"]
    
    var padding : CGFloat = 20
    
    init(title: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
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
            view_containerView.heightAnchor.constraint(equalToConstant: 320),
            view_containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    func ConfigurePickerView(){
        view_containerView.addSubview(pickerView_selection)
        pickerView_selection.delegate = self
        pickerView_selection.dataSource = self
        pickerView_selection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView_selection.centerXAnchor.constraint(equalTo: view_containerView.centerXAnchor),
            pickerView_selection.centerYAnchor.constraint(equalTo: view_containerView.centerYAnchor, constant: -10),
            pickerView_selection.widthAnchor.constraint(equalToConstant: 300),
            pickerView_selection.heightAnchor.constraint(equalToConstant: 186)
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
        print(selectedOption)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func Btn_Cancel(){
        dismiss(animated: true, completion: nil)
    }
}

extension NF_SelectOption_VC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectionList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = selectionList[row]
       return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = selectionList[row]
    }
}
