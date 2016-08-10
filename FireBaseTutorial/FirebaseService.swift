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
    
    let baseURL = "https://fir-tutorial-df177.firebaseio.com/"
    
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
            let ref = FIRDatabase.database().referenceFromURL(self.baseURL)
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
    
    static let sharedInstace = FirebaseService()
    
}