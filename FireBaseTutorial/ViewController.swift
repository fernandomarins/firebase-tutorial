//
//  ViewController.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 08/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
        
    }
    
    func handleLogout() {
        let loginViewController = LoginViewController()
        presentViewController(loginViewController, animated: true, completion: nil)
    }
    
}


