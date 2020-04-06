//
//  Helper.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 03/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class Helper {
    static func TotalNumberOfLines(text: String) -> Int {
        guard !text.isEmpty else { return 1}
        
        let sidePadding : CGFloat = 40
        let screenWidth = UIScreen.main.bounds.width - sidePadding
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.numberOfLines = 0
        label.text = text
        label.lineBreakMode = .byWordWrapping
        let rectOfLabel = label.textRect(forBounds: CGRect(x: 0, y: 0, width: screenWidth, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 0)
        let rectOfLabelOneLine = label.textRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 1)
        let heightOfLabel = rectOfLabel.height
        let heightOfLine = rectOfLabelOneLine.height
        let numberOfLines = Int(heightOfLabel / heightOfLine) + 1
        return numberOfLines
    }
}
