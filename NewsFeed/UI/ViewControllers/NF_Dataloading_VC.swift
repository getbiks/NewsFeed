//
//  NF_Dataloading_VC.swift
//  NewsFeed
//
//  Created by Bikash Agarwal on 04/05/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit

class NF_Dataloading_VC: UIViewController {

    var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func ShowLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.AddSubViews(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.AddSubViews(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func DismissLoadingView(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }

}
