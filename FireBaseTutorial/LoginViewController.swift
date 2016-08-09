//
//  LoginViewController.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 09/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let inputsContaiverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsContaiverView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileView()
    }
    
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
        
        nameTextField.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor, constant: 12).active = true
        nameTextField.topAnchor.constraintEqualToAnchor(inputsContaiverView.topAnchor).active = true
        nameTextField.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        nameTextField.heightAnchor.constraintEqualToAnchor(inputsContaiverView.heightAnchor, multiplier: 1/3).active = true
        
        // name separator
        // need x, y, width, height
        
        nameSeparator.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor).active = true
        nameSeparator.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        nameSeparator.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        nameSeparator.heightAnchor.constraintEqualToConstant(1).active = true
        
        // email text field
        // need x, y, width, height
        
        emailTextField.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor, constant: 12).active = true
        emailTextField.topAnchor.constraintEqualToAnchor(nameTextField.bottomAnchor).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        emailTextField.heightAnchor.constraintEqualToAnchor(inputsContaiverView.heightAnchor, multiplier: 1/3).active = true
        
        // email separator
        // need x, y, width, height
        
        emailSeparator.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor).active = true
        emailSeparator.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        emailSeparator.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        emailSeparator.heightAnchor.constraintEqualToConstant(1).active = true
        
        // password text field
        // need x, y, width, height
        
        passwordTextField.leftAnchor.constraintEqualToAnchor(inputsContaiverView.leftAnchor, constant: 12).active = true
        passwordTextField.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        passwordTextField.heightAnchor.constraintEqualToAnchor(inputsContaiverView.heightAnchor, multiplier: 1/3).active = true
    }
    
    func setupLoginRegisterButton() {
        // need x, y, width, height
        
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        loginRegisterButton.topAnchor.constraintEqualToAnchor(inputsContaiverView.bottomAnchor, constant: 12).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContaiverView.widthAnchor).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(50).active = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}