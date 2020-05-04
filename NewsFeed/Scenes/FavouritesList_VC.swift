//
//  FavouritesList_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 19/03/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class FavouritesList_VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        ShowEmptyStateView(message: "No favourites to show. \nThe article you have favourited will appear here.", view: self.view)
    }

}
