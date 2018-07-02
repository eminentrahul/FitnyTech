//
//  SignInViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 28/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {

	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var signInButton: UIButton!
	
	
	@IBOutlet weak var googleSignIn: GIDSignInButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		GIDSignIn.sharedInstance().uiDelegate = self
		
		NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
		
		//EmailTextField
		emailTextField.backgroundColor = .clear
		emailTextField.tintColor = .white
		emailTextField.textColor = .white
		emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
		
		let emailBottomLayer = CALayer()
		emailBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
		emailBottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
		emailTextField.layer.addSublayer(emailBottomLayer)
		
		//PasswordTextField
		passwordTextField.backgroundColor = .clear
		passwordTextField.tintColor = .white
		passwordTextField.textColor = .white
		passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
		
		let passwordBottomLayer = CALayer()
		passwordBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
		passwordBottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
		passwordTextField.layer.addSublayer(passwordBottomLayer)
		
		signInButton.isEnabled = false
		
		self.validateTextFiels()
		
    }
	
	@objc func didSignIn()  {
		
		// Add your code here to push the new view controller
		self.performSegue(withIdentifier: "goToTabBarViewController", sender: self)
		
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	
	//If the current user does not log out from the app
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if Auth.auth().currentUser != nil {
			self.performSegue(withIdentifier: "goToTabBarViewController", sender: nil)
		}
	}
	
	
	@IBAction func signInButtonClicked(_ sender: Any) {
		
		view.endEditing(true)
		
		ProgressHUD.show("Waiting", interaction: false)
		
		Authentication.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
			
			ProgressHUD.showSuccess("Success!")
			// perform segue on success
			self.performSegue(withIdentifier: "goToTabBarViewController", sender: nil)
		}, onError: {error in
				//On failure show warning
			ProgressHUD.showError(error)
				
				})
		
		
	}
	
	//MARK: Validation for text inputs
	//Validation for text inputs
	func validateTextFiels() {
		
		emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
		
		passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
	}
	
	@objc func textFieldDidChange() {
		
		guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
			signInButton.setTitleColor(.lightText, for: .normal)
			signInButton.isEnabled = false
			return
		}
		signInButton.setTitleColor(.white, for: .normal)
		signInButton.isEnabled = true
		
	}
	
	@IBAction func googleSignInClicked(_ sender: Any) {
		
		ProgressHUD.show("Waiting", interaction: false)
		GIDSignIn.sharedInstance().signIn()
		ProgressHUD.dismiss()
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}


}
