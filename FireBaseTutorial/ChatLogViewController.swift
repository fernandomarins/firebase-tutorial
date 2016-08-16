//
//  ChatLogViewController.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 11/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import UIKit
import Firebase

class ChatLogViewController: UICollectionViewController, UITextFieldDelegate {
    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        setupInputComponents()

    }
    
    func setupInputComponents(){
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        // ios 9 constraints
        // need x, y, width and height
        
        containerView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        containerView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        containerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        containerView.heightAnchor.constraintEqualToConstant(50).active = true
        
        let sendButton = UIButton(type: .System)
        containerView.addSubview(sendButton)
        sendButton.setTitle("Send", forState: .Normal)
        sendButton.addTarget(self, action: #selector(handleSend), forControlEvents: .TouchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        // ios 9 constraints
        // need x, y, width and height
        
        sendButton.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor).active = true
        sendButton.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        sendButton.widthAnchor.constraintEqualToConstant(80).active = true
        sendButton.heightAnchor.constraintEqualToAnchor(containerView.heightAnchor).active = true
        
        containerView.addSubview(inputTextField)
        
        // ios 9 constraints
        // need x, y, width and height
        
        inputTextField.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor, constant: 8).active = true
        inputTextField.centerYAnchor.constraintEqualToAnchor(containerView.centerYAnchor).active = true
        inputTextField.rightAnchor.constraintEqualToAnchor(sendButton.leftAnchor).active = true
        inputTextField.heightAnchor.constraintEqualToAnchor(containerView.heightAnchor).active = true
        
        let separatedLineView = UIView()
        containerView.addSubview(separatedLineView)
        separatedLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatedLineView.translatesAutoresizingMaskIntoConstraints = false
        
        // ios 9 constraints
        // need x, y, width and height
        separatedLineView.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
        separatedLineView.topAnchor.constraintEqualToAnchor(containerView.topAnchor).active = true
        separatedLineView.widthAnchor.constraintEqualToAnchor(containerView.widthAnchor).active = true
        separatedLineView.heightAnchor.constraintEqualToConstant(1).active = true
        
    }
    
    func handleSend() {
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        //is it there best thing to include the name inside of the message node
        let toId = user!.id!
        let fromId = FIRAuth.auth()!.currentUser!.uid
        let timestamp: NSNumber = Int(NSDate().timeIntervalSince1970)
        let values = ["text": inputTextField.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp]
        childRef.updateChildValues(values)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        handleSend()
        return true
    }

}
