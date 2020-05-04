//
//  PersistenceManager.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 04/04/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum LanguageType {
    case languageName, languageCode
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum keys {
        static let disclaimerViewed = "disclaimerViewed"
        static let languageCode = "languageCode"
        static let languageName = "languageName"
    }
    
    static func SaveLanguage(language: String, languageCode : String) {
        defaults.set(language, forKey: keys.languageName)
        defaults.set(languageCode, forKey: keys.languageCode)
    }
    
    static func SaveDiscliamerViewed(value: Int){
        defaults.set(value, forKey: keys.disclaimerViewed)
    }
    
    static func RetrieveDisclaimerViewed() -> Int {
        return defaults.integer(forKey: keys.disclaimerViewed)
    }
    
    static func RetrieveLanguage(type: LanguageType) -> String {
        switch type {
        case .languageCode:
            guard let languageCode = defaults.object(forKey: keys.languageCode) else {
                return ("en")
            }
            return (languageCode as! String)
        case .languageName:
            guard let languageName = defaults.object(forKey: keys.languageName) else {
                return ("English")
            }
            return (languageName as! String)
        }
    }
}
