//
//  Authentication.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 30/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class Authentication {
	
	//Authentication for signIn process
	static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String) -> Void){
		
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			if error != nil {
				onError(error!.localizedDescription)
				return
			}
			onSuccess()
		}
	}
	
	//Authentication for signUp process
	static func signUp(username : String, email : String, password : String, onSuccess : @escaping () -> Void, onError : @escaping (_ errorMessage : String) -> Void) {
		
		Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
			if error != nil {
				onError(error!.localizedDescription)
				return
			}
			
			//Store user details here
			let ref = Database.database().reference()
			let userReference = ref.child("Users")
			let newUserReference = userReference.childByAutoId()
			newUserReference.setValue(["username" : username, "email" : email])
			
			onSuccess()
			
			print("Description: \(newUserReference.description())")
		}
		
	}
	
	//Store user details
	
}
