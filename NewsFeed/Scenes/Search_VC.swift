//
//  Search_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 03/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class Search_VC: UIViewController {

    let button_menu = UIButton(type: .custom)
    let label_logo1 = NF_Label_Title(fontSize: 16, fontWeight: .regular, lines: 0, textAlignment: .center)
    let label_logo2 = NF_Label_Title(fontSize: 40, fontWeight: .bold, lines: 0, textAlignment: .center)
    let textField_username = NF_TextField(placeholderText: "Enter keyword to search", keyboardType: .default, returnKeyType: .go)
    let button_search = NF_Button(backgroundColor: .systemRed, title: "Search", titleColor: .white)
    let label_copyright = NF_Label_Title(fontSize: 14, fontWeight: .regular, lines: 0, textAlignment: .center)
    
    var isSearchKeywordEnteres: Bool {
        return !textField_username.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        ConfigureMenuButton()
        ConfigureUsernameTextField()
        ConfigureSearchButton()
        ConfigureLogoLabel()
        ConfigureCopyrightLabel()
        CreateDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        textField_username.text = ""
    }
    
    func CreateDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func Btn_Search(){
        guard isSearchKeywordEnteres else {
            PresentAlertScreen(title: "Error", message: "Enter keyword to search News related to that topic", buttonTitle: "OK")
            return
        }
        
        let searchText = textField_username.text?.removeWhitespaces()
        let newsfeedVC = NewsFeed_VC(keyword: searchText!)
        navigationController?.pushViewController(newsfeedVC, animated: true)
        view.endEditing(true)
    }
    
    @objc func Btn_Menu(){
        print("Menu Clicked")
    }
    
    func ConfigureMenuButton(){
        view.addSubview(button_menu)
        let buttonImage = SFSymbols.menu
        button_menu.setImage(buttonImage, for: .normal)
        button_menu.addTarget(self, action:#selector(Btn_Menu), for: .touchUpInside)
        button_menu.tintColor = .systemRed
        button_menu.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button_menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button_menu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button_menu.widthAnchor.constraint(equalToConstant: 50),
            button_menu.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func ConfigureUsernameTextField(){
        view.addSubview(textField_username)
        textField_username.delegate = self
        
        NSLayoutConstraint.activate([
            textField_username.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            textField_username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField_username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField_username.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func ConfigureLogoLabel(){
        view.AddSubViews(label_logo1, label_logo2)
        
        label_logo1.text = "Powered by"
        label_logo2.text = "News API"
        
        NSLayoutConstraint.activate([
            label_logo2.bottomAnchor.constraint(equalTo: textField_username.topAnchor, constant: -20),
            label_logo2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label_logo2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label_logo2.heightAnchor.constraint(equalToConstant: 50),
            
            label_logo1.bottomAnchor.constraint(equalTo: label_logo2.topAnchor, constant: -10),
            label_logo1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label_logo1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label_logo1.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func ConfigureSearchButton(){
        view.addSubview(button_search)
        button_search.addTarget(self, action: #selector(Btn_Search), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button_search.topAnchor.constraint(equalTo: textField_username.bottomAnchor, constant: 25),
            button_search.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button_search.widthAnchor.constraint(equalToConstant: 200),
            button_search.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func ConfigureCopyrightLabel(){
        view.addSubview(label_copyright)
        
        label_copyright.text = "© Developed by Bikash Agarwal. \nNews fetched from newsapi.org using Open Source & Non Commercial License."
        
        NSLayoutConstraint.activate([
            label_copyright.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            label_copyright.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            label_copyright.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            label_copyright.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension Search_VC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Btn_Search()
        return true
    }
}
