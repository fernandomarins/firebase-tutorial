//
//  Hud.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 10/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import Foundation
import MBProgressHUD

func waitHud(title:String?, view:UIView){
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
    if title != nil {
        hud.labelText = title
    }
}
func dismissHud(view:UIView){
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    MBProgressHUD.hideAllHUDsForView(view, animated: true)
}