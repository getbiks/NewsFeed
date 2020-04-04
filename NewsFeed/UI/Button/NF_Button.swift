//
//  NF_Button.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 09/01/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        Configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title : String, titleColor : UIColor){
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }
    
    private func Configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    func Set(backgroundColor: UIColor, title: String){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
}
