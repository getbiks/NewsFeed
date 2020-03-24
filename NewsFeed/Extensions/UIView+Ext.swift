//
//  UIView+Ext.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

extension UIView {
    func AddSubViews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
