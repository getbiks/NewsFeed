//
//  NF_Empty_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 24/02/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_Empty_VC: UIView {

    let label_message = NF_Label_Title(fontSize: 20, fontWeight: .regular, lines: 0, textAlignment: .center)
    let imageView_logo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        label_message.text = message
        Configure()
    }
     
    private func Configure(){
        AddSubViews(label_message, imageView_logo)
        
        label_message.textColor = .secondaryLabel
        
        imageView_logo.image = Images.emptyImage
        imageView_logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView_logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView_logo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView_logo.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView_logo.heightAnchor.constraint(equalTo: self.widthAnchor),
            
            label_message.bottomAnchor.constraint(equalTo: imageView_logo.topAnchor, constant: 35),
            label_message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            label_message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            label_message.centerXAnchor.constraint(equalTo: imageView_logo.centerXAnchor)
        ])
    }
}
