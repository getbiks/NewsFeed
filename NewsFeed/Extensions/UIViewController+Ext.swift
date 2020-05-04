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
    
    func ShowAlertScreen(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = nil
            let alertVC = NF_Alert_VC(title: title, message: message, buttonTitle : buttonTitle)
            alertVC.modalPresentationStyle = .overCurrentContext
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
            
        }
    }
    
    func ShowDisclaimerScreen(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = nil
            let helpVC = NF_Disclaimer_VC(title: title, message: message, buttonTitle: buttonTitle)
            helpVC.modalPresentationStyle = .overCurrentContext
            helpVC.modalTransitionStyle = .crossDissolve
            self.present(helpVC, animated: true)
        }
    }
    
    func ShowEmptyStateView(message: String, view: UIView){
        self.navigationItem.rightBarButtonItems = nil
        let emptyStateView = NF_Empty_VC(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func ShowOptionSelectionVC(selectType: SelectionType,title: String, optionList: [String], delegate: SelectOptionDelegate){
        DispatchQueue.main.async {
            let selectVC = NF_SelectOption_VC(selectType: selectType,title: title, optionList: optionList)
            selectVC.delegate = delegate
            selectVC.modalPresentationStyle = .overCurrentContext
            selectVC.modalTransitionStyle = .crossDissolve
            self.present(selectVC, animated: true)
        }
    }
    
    func ShowDatePickerVC(dateType: CustomDateType, title: String, delegate: DatePickerDelegate){
        DispatchQueue.main.async {
            let customDateVC = NF_DatePicker_VC(dateType: dateType, title: title)
            customDateVC.delegate = delegate
            customDateVC.modalPresentationStyle = .overCurrentContext
            customDateVC.modalTransitionStyle = .crossDissolve
            self.present(customDateVC, animated: true)
        }
    }
}
