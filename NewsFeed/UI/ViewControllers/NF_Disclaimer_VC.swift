//
//  NF_Help_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 16/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_Disclaimer_VC: UIViewController {

    let view_containerView = UIView()
    let label_title = NF_Label_Title(fontSize: 20, fontWeight: .bold, lines: 1, textAlignment: .center)
    let label_body = NF_Label_Body(fontSize: 16, fontWeight: .medium, textAlignment: .center)
    let button_dismiss = NF_Button(backgroundColor: .systemRed, title: "OK", titleColor: .white)
    
    var alertTitle : String?
    var alertMessage : String?
    var buttonTitle : String?
    
    var padding : CGFloat = 20
    
    init(title: String, message: String, buttonTitle : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        ConfigureContainerView()
        ConfigureTitleLabel()
        ConfigureDismissButton()
        ConfigureBodyLabel()
    }
    
    func ConfigureContainerView(){
        view.AddSubViews(view_containerView)
        view_containerView.backgroundColor = .systemBackground
        view_containerView.layer.cornerRadius = 16
        view_containerView.layer.borderWidth = 2
        view_containerView.layer.borderColor = UIColor.white.cgColor
        view_containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view_containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view_containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view_containerView.heightAnchor.constraint(equalToConstant: 450),
            view_containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func ConfigureTitleLabel(){
        view_containerView.AddSubViews(label_title)
        label_title.text = alertTitle ?? "Alert Title"
        label_title.textColor = .systemRed
        
        NSLayoutConstraint.activate([
            label_title.topAnchor.constraint(equalTo: view_containerView.topAnchor, constant: padding),
            label_title.leadingAnchor.constraint(equalTo: view_containerView.leadingAnchor, constant: padding),
            label_title.trailingAnchor.constraint(equalTo: view_containerView.trailingAnchor, constant: -padding),
            label_title.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func ConfigureDismissButton(){
        view_containerView.addSubview(button_dismiss)
        button_dismiss.layer.cornerRadius = 22
        button_dismiss.setTitle(buttonTitle ?? "OK", for: .normal)
        
        button_dismiss.addTarget(self, action: #selector(Btn_Dismiss), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button_dismiss.bottomAnchor.constraint(equalTo: view_containerView.bottomAnchor, constant: -padding),
            button_dismiss.leadingAnchor.constraint(equalTo: view_containerView.leadingAnchor, constant: padding),
            button_dismiss.trailingAnchor.constraint(equalTo: view_containerView.trailingAnchor, constant: -padding),
            button_dismiss.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func ConfigureBodyLabel(){
        view_containerView.AddSubViews(label_body)
        label_body.text = alertMessage ?? "Unable to complete request"
        label_body.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            label_body.topAnchor.constraint(equalTo: label_title.bottomAnchor, constant: 8),
            label_body.bottomAnchor.constraint(equalTo: button_dismiss.topAnchor, constant: -12),
            label_body.leadingAnchor.constraint(equalTo: view_containerView.leadingAnchor, constant: padding),
            label_body.trailingAnchor.constraint(equalTo: view_containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    @objc func Btn_Dismiss(){
        PersistenceManager.SaveDiscliamerViewed(value: 1)
        dismiss(animated: true, completion: nil)
    }

}
