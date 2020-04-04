//
//  NF_Button_ReadMore.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_Button_ReadMore: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    }
    
    private func Configure(){
        translatesAutoresizingMaskIntoConstraints = false
        contentHorizontalAlignment = .leading
        self.setTitleColor(.systemRed, for: .normal)
    }

}
