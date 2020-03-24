//
//  NF_BodyLabel.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_Label_Body: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat, fontWeight: UIFont.Weight){
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    private func Configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor                           = .label
        textAlignment                       = .left
        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        //numberOfLines                       = 2
    }

}
