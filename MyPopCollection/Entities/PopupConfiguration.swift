//
//  PopupConfiguration.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 13/10/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation
import PopupDialog

class PopupConfiguration {
    
    class func configurePopupAppearance() {
        configureDialogAppearance()
        configureOverlayAppearance()
        configureButtonAppearance()
    }
    
    private class func configureDialogAppearance() {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.boldSystemFont(ofSize: 18.0)
        dialogAppearance.titleColor = Colors.normalYellow
        dialogAppearance.messageFont = UIFont.systemFont(ofSize: 15.0)
        dialogAppearance.messageColor = Colors.darkGray
    }

    private class func configureOverlayAppearance() {
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color = UIColor.clear
        overlayAppearance.blurRadius = 10.0
    }
    
    private class func configureButtonAppearance() {
        let buttonAppearance = DefaultButton.appearance()
        buttonAppearance.titleFont = UIFont.systemFont(ofSize: 15.0)
        buttonAppearance.titleColor = UIColor.black
        
        // Cancel button
        CancelButton.appearance().titleColor = UIColor.lightGray
        
        // Destructive button
        DestructiveButton.appearance().titleColor = UIColor.red
    }
}
