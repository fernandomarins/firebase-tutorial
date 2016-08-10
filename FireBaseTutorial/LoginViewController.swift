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
    let inputsContainerView: UIView = {
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
        button.addTarget(self, action: #selector(handleLoginRegister), forControlEvents: .TouchUpInside)
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
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.whiteColor()
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), forControlEvents: .ValueChanged)
        return sc
    }()

    // Mark: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        
    }
    
    // Mark: Configuring UI
    
    func setupLoginRegisterSegmentedControl() {
        //need x, y, width, height constraints
        
        loginRegisterSegmentedControl.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterSegmentedControl.bottomAnchor.constraintEqualToAnchor(inputsContainerView.topAnchor, constant: -12).active = true
        loginRegisterSegmentedControl.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterSegmentedControl.heightAnchor.constraintEqualToConstant(36).active = true
    }
    
    func setupProfileView() {
        // need x, y, width, height
        
        profileImageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        profileImageView.bottomAnchor.constraintEqualToAnchor(loginRegisterSegmentedControl.topAnchor, constant: -12).active = true
        profileImageView.widthAnchor.constraintEqualToConstant(150).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(150).active = true
    }
    
    // Creating a reference to this height so we can change it later
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldAnchor: NSLayoutConstraint?
    
    func setupInputsContainerView() {
        // need x, y, width, height
        
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -24).active = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraintEqualToConstant(150)
        inputsContainerViewHeightAnchor?.active = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparator)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparator)
        inputsContainerView.addSubview(passwordTextField)
        
        //need x, y, width, height constraints
        textFieldInputsView(nameTextField, anchor: inputsContainerView.topAnchor)
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.active = true
        
        //need x, y, width, height constraints
        separatorInputsView(nameSeparator, anchor: nameTextField.bottomAnchor)
        
        //need x, y, width, height constraints
        textFieldInputsView(emailTextField, anchor: nameTextField.bottomAnchor)
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.active = true
        
        //need x, y, width, height constraints
        separatorInputsView(emailSeparator, anchor: emailTextField.bottomAnchor)
        
        //need x, y, width, height constraints
        textFieldInputsView(passwordTextField, anchor: emailTextField.bottomAnchor)
        passwordTextFieldAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldAnchor?.active = true

    }
    
    func setupLoginRegisterButton() {
        // need x, y, width, height
        
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
    }
    
    // Add a text field to inputsView
    func textFieldInputsView(textField: UITextField, anchor: NSLayoutAnchor) {
        textField.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor, constant: 12).active = true
        textField.topAnchor.constraintEqualToAnchor(anchor).active = true
        textField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
    }
    
    // Add a separator to inputsView
    func separatorInputsView(view: UIView, anchor: NSLayoutAnchor) {
        view.leftAnchor.constraintEqualToAnchor(inputsContainerView.leftAnchor).active = true
        view.topAnchor.constraintEqualToAnchor(anchor).active = true
        view.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        view.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    // Mark: Login/Register handle
    func handleLoginRegisterChange() {
        // The title will be changed according to the segmented index selected
        let title = loginRegisterSegmentedControl.titleForSegmentAtIndex(loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, forState: .Normal)
        
        // Change height of inputsContainerView
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // Change height nameTextField
        nameTextFieldHeightAnchor?.active = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.active = true
        
        // Change height emailTextField
        emailTextFieldHeightAnchor?.active = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.active = true
        
        // Change height passwordTextField
        passwordTextFieldAnchor?.active = false
        passwordTextFieldAnchor = passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldAnchor?.active = true
        
    }
    
    // Mark: Register user
    
    func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        
        guard let email = emailTextField.text, password = passwordTextField.text else {
            performUpdatesOnMain({
                self.alertWithTitle("Attention!", message: "Please enter all info required.")
            })
            
            return
        }
        
        FirebaseService.sharedInstace.singIn(email, password: password, failure: { (errorMessage) in
            performUpdatesOnMain({ 
                self.alertWithTitle("Attention!", message: errorMessage)
            })
            
            }) {
                
                self.dismissViewControllerAnimated(true, completion: nil)

        }
        
    }
    
    func handleRegister() {
        
        guard let email = emailTextField.text, password = passwordTextField.text, name = nameTextField.text else {
            performUpdatesOnMain({
                self.alertWithTitle("Attention!", message: "Please enter all info required.")
            })
            
            return
        }
        
        FirebaseService.sharedInstace.createUser(email, password: password, name: name, failure: { (errorMessage) in
            
            performUpdatesOnMain({
                self.alertWithTitle("Attention!", message: errorMessage)
            })
            
        }) {
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
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

