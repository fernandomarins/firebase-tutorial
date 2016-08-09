//
//  ViewController.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 08/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController,
    GIDSignInDelegate,
    GIDSignInUIDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    @IBAction func signInAction(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("User logged in...")
            }
            
        })
    }

    @IBAction func signUpAction(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("User created...")
            }
            
        })
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let authentication = user.authentication
        let crendetial = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken, accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signInWithCredential(crendetial, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            print("User logged in with Google...")
        })
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            
        }
    }
    
}

extension LoginViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}

