//
//  UIViewController+Ext.swift
//  GHFollower
//
//  Created by Bikash Agarwal on 12/01/20.
//  Copyright © 2020 Bikash Agarwal. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func ShowSafariVC(with url: URL){
        let safari_VC = SFSafariViewController(url: url)
        safari_VC.preferredControlTintColor = .systemRed
        present(safari_VC, animated: true, completion: nil)
    }
    
    func CalculateImageHeight(image: UIImage) -> CGFloat {
        let sidePadding : CGFloat = 40
        let imageCrop = image.GetCropRatio()
        let imgHeight = ((UIScreen.main.bounds.size.width - sidePadding) / imageCrop)
        return imgHeight
    }
    
    func PresentAlertScreen(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = NF_Alert_VC(title: title, message: message, buttonTitle : buttonTitle)
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
            
        }
    }
    
    func PresentSelectionScreen(title: String){
        DispatchQueue.main.async {
            let selectVC = NF_SelectOption_VC(title: title)
            selectVC.modalPresentationStyle = .overCurrentContext
            selectVC.modalTransitionStyle = .crossDissolve
            self.present(selectVC, animated: true)
            
        }
    }
}
