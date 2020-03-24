//
//  UIImage+Ext.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 21/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

extension UIImage {
    func GetCropRatio() -> CGFloat {
        let widthRatio = CGFloat((self.size.width) / self.size.height)
        return widthRatio
    }
}
