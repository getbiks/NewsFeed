//
//  Constants.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

enum SFSymbols {
    static let newsFeed     = UIImage(systemName: "bolt.circle.fill")
    static let favourites   = UIImage(systemName: "star.fill")
    static let menu         = UIImage(systemName: "text.justify", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium))
}

enum Images {
    static let emptyImage = UIImage(named: "placeholder_NewsIcon")
    static let newsIcon = UIImage(named: "placeholder_NewsIcon")
    static let noImage = UIImage(named: "placeholder_NoImage")
}

enum Options {
    static let languageCodeList = ["en", "hi", "de", "ar", "es", "fr", "he", "it", "nl", "no", "pt", "ru", "zh"]
    static let languageList = ["English", "Hindi", "German", "Arabic", "Spanish", "French", "Hebrew", "Italian", "Dutch", "Norweigian", "Portugese", "Russian", "Chinese"]
    static let dateList = ["All", "Yesterday", "Last 7 Days", "Last 30 Days", "Custom"]
    static let dateListCode = [0,1,7,30, -1]
}
