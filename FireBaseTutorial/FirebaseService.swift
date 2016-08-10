//
//  FirebaseService.swift
//  FireBaseTutorial
//
//  Created by Fernando Augusto de Marins on 09/08/16.
//  Copyright © 2016 Fernando, Inc. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseService {
    
    // Create user firebase
    func createUser(email: String, password: String, name: String, failure: (errorMessage: String) -> Void, success: () -> Void) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                failure(errorMessage: (error!.localizedDescription))
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // user created
            let ref = FIRDatabase.database().referenceFromURL(Constants().baseURL)
            let usersRerefence = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersRerefence.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    failure(errorMessage: err!.localizedDescription)
                    return
                }
                
                success()
            })
        })
    }
    
    // Sign in user firebase
    func singIn(email: String, password: String, failure: (errorMessage: String) -> Void, success: () -> Void) {
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error != nil {
                failure(errorMessage: error!.localizedDescription)
                return
            }
            
            success()
            
        })
    }
    
    func logout(failure: (errorMessage: ErrorType) -> Void) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            failure(errorMessage: logoutError)
        }
    }
    
    // Singleton
    static let sharedInstace = FirebaseService()
    
}