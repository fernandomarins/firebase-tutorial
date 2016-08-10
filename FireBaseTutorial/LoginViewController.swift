//
//  LoginViewController.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 09/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // Mark: Creating UI Elements
    let inputsContaiverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.addTarget(self, action: #selector(handleRegister), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.autocapitalizationType = UITextAutocapitalizationType.None
        tf.autocorrectionType = UITextAutocorrectionType.No
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = UITextAutocapitalizationType.None
        tf.autocorrectionType = UITextAutocorrectionType.No
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.secureTextEntry = true
        tf.autocapitalizationType = UITextAutocapitalizationType.None
        tf.autocorrectionType = UITextAutocorrectionType.No
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gameofthrones_splash")
        imageView.contentMode = .ScaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Mark: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(inputsContaiverView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileView()
    }
    
    // Mark: Register user
    
    func handleRegister() {
        
        guard let email = emailTextField.text, password = passwordTextField.text, name = nameTextField.text else {
            alertWithTitle("Attention!", message: "Please enter all info required.")
            print("Form is not valid")
            return
        }
        
        FirebaseService.sharedInstace.createUser(email, password: password, name: name, failure: { (errorMessage) in
            
            self.alertWithTitle("Attention!", message: errorMessage)
            
            }) {
                
                self.alertWithTitle("Great!", message: "User was created!")
                
        }
        
//        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
//            if error != nil {
//                self.alertWithTitle("Attention!", message: (error!.localizedDescription))
//                return
//            }
//            
//            guard let uid = user?.uid else {
//                return
//            }
//            
//            // user created
//            let baseURL = "https://fir-tutorial-df177.firebaseio.com/"
//            let ref = FIRDatabase.database().referenceFromURL(baseURL)
//            let usersRerefence = ref.child("users").child(uid)
//            let values = ["name": name, "email": email]
//            usersRerefence.updateChildValues(values, withCompletionBlock: { (err, ref) in
//                if err != nil {
//                    self.alertWithTitle("Attention!", message: (err!.localizedDescription))
//                    print(err?.localizedDescription)
//                    return
//                }
//                
//                self.alertWithTitle("Great!", message: "User was successfully created.")
//            })
//        })
        
    }
    
    // Mark: Configuring UI
    
    func setupProfileView() {
        // need x, y, width, height
        
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        profileImageView.bottomAnchor.constraintEqualToAnchor(inputsContaiverView.topAnchor, constant: -12).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(150).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(150).active = true
    }
    
    func setupInputsContainerView() {
        // need x, y, width, height
        
        inputsContaiverView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContaiverView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContaiverView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputsContaiverView.heightAnchor.constraintEqualToConstant(150).active = true
        
        inputsContaiverView.addSubview(nameTextField)
        inputsContaiverView.addSubview(nameSeparator)
        inputsContaiverView.addSubview(emailTextField)
        inputsContaiverView.addSubview(emailSeparator)
        inputsContaiverView.addSubview(passwordTextField)
        
        // name text field
        // need x, y, width, height
        
        textFieldInputsView(nameTextField, anchor: inputsContaiverView.topAnchor)
        
        // name separator
        // need x, y, width, height
        
        separatorInputsView(nameSeparator, anchor: nameTextField.bottomAnchor)
        
        // email text field
        // need x, y, width, height
        
        textFieldInputsView(emailTextField, anchor: nameTextField.bottomAnchor)
        
        // email separator
        // need x, y, width, height
        
        separatorInputsView(emailSeparator, anchor: emailTextField.bottomAnchor)
        
        // password text field
        // need x, y, width, height
        
        textFieldInputsView(passwordTextField, anchor: emailTextField.bottomAnchor)

    }
    
    func setupLoginRegisterButton() {
        // need x, y, width, height
        
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContaiverView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
    }
    
    // Add a text field to inputsView
    func textFieldInputsView(textField: UITextField, anchor: NSLayoutAnchor) {
        textField.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor, constant: 12).active = true
        textField.topAnchor.constraintEqualToAnchor(anchor).active = true
        textField.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        textField.heightAnchor.constraintEqualToAnchor(inputsContaiverView.heightAnchor, multiplier: 1/3).active = true
    }
    
    // Add a separator to inputsView
    func separatorInputsView(view: UIView, anchor: NSLayoutAnchor) {
        view.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor).active = true
        view.topAnchor.constraintEqualToAnchor(anchor).active = true
        view.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        view.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}

