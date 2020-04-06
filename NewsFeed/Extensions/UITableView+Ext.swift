//
//  UITableView+Ext.swift
//  GHFollower
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

extension UITableView {
    
    func RemoveExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
