//
//  MessagesViewController.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 08/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    func handleNewMessage() {
        let newMessageVC = NewMessagesViewController()
        let navController = UINavigationController(rootViewController: newMessageVC)
        presentViewController(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
                
            }, withCancelBlock: nil)
        }
    }
    
    func handleLogout() {
        
        if Reachability.isConnectedToNetwork() {
            FirebaseService.sharedInstace.logout { (errorMessage) in
                if let errMessage = errorMessage as? String {
                    self.alertWithTitle("Attention!", message: errMessage)
                }
            }
            
            presentLoginView()
        } else {
            alertWithTitle("Attention!", message: "Your device is not connected to the internet.")
        }
        
        
    }
    
    func presentLoginView() {
        let loginViewController = LoginViewController()
        presentViewController(loginViewController, animated: true, completion: nil)
    }
    
}


