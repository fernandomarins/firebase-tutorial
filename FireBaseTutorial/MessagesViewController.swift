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
        
        observeMesssages()
    }
    
    var messages = [Messages]()
    
    func observeMesssages() {
        
        let ref = FIRDatabase.database().reference().child("messages")
        ref.observeSingleEventOfType(.ChildAdded, withBlock: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Messages()
                print(snapshot)
                message.setValuesForKeysWithDictionary(dictionary)
                self.messages.append(message)
                
                performUpdatesOnMain({ 
                    self.tableView.reloadData()
                })

            }
            
            }, withCancelBlock: nil)
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cellId")
        
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func handleNewMessage() {
        let newMessageVC = NewMessagesViewController()
        newMessageVC.messagesVC = self
        let navController = UINavigationController(rootViewController: newMessageVC)
        presentViewController(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                user.setValuesForKeysWithDictionary(dictionary)
                self.setupNavBarWithUser(user)
            }
            
            }, withCancelBlock: nil)
    }
    
    func setupNavBarWithUser(user: User) {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .ScaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        containerView.addSubview(profileImageView)
        
        //ios 9 constraint anchors
        //need x,y,width,height anchors
        profileImageView.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
        profileImageView.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(40).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(40).active = true
        
        let nameLabel = UILabel()
        
        // Always add the element after creating it, otherwise app will crash
        containerView.addSubview(nameLabel)
        nameLabel.text = user.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        //need x,y,width,height anchors
        nameLabel.leftAnchor.constraintEqualToAnchor(profileImageView.rightAnchor, constant: 8).active = true
        nameLabel.centerYAnchor.constraintEqualToAnchor(profileImageView.centerYAnchor).active = true
        nameLabel.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor).active = true
        nameLabel.heightAnchor.constraintEqualToAnchor(profileImageView.heightAnchor).active = true
        
        containerView.centerXAnchor.constraintEqualToAnchor(titleView.centerXAnchor).active = true
        containerView.centerYAnchor.constraintEqualToAnchor(titleView.centerYAnchor).active = true
        
        navigationItem.titleView = titleView
        
//        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))
    }
    
    func showChatController(user: User) {
        let chatVC = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chatVC.user = user
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        presentLoginView()
        
    }
    
    func presentLoginView() {
        let loginViewController = LoginViewController()
        loginViewController.messagesVC = self
        presentViewController(loginViewController, animated: true, completion: nil)
    }
    
}


