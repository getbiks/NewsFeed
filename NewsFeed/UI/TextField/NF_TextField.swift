//
//  NF_TextField.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 11/01/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        Configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholderText : String, keyboardType : UIKeyboardType, returnKeyType: UIReturnKeyType) {
        self.init(frame: .zero)
        self.placeholder = placeholderText
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
    }
    
    private func Configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        autocapitalizationType = .none
    }
    
}
