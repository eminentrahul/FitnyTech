//
//  SignUpViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 28/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

	@IBOutlet weak var usernameTextField: UITextField!
	
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var signUpButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		//UsernameTextField
		usernameTextField.backgroundColor = .clear
		usernameTextField.tintColor = .white
		usernameTextField.textColor = .white
		usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
		
		let usernameBottomLayer = CALayer()
		usernameBottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
		usernameBottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
		usernameTextField.layer.addSublayer(usernameBottomLayer)

		
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
		
		signUpButton.isEnabled = false

		self.validateTextFiels()
    }

	@IBAction func existingUser(_ sender: Any) {
		
		dismiss(animated: true, completion: nil)
		
	}
	
	
	@IBAction func signUpButtonClicked(_ sender: UIButton) {
		
		view.endEditing(true)
		
		ProgressHUD.show("Waiting", interaction: false)
		
		Authentication.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
			//Do some stuff on successful
			ProgressHUD.showSuccess("Success!")
			self.performSegue(withIdentifier: "signUpToTabBarViewController", sender: nil)
		}, onError: { errorMessage in
			//Do some stuff here on failure
			ProgressHUD.showError(errorMessage)
		})
		
	}
	
	
	//MARK: Validation for text inputs
	//Validation for text inputs
	func validateTextFiels() {
		
		usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
		
		emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
		
		passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
	}
	
	@objc func textFieldDidChange() {
		
		guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
			signUpButton.setTitleColor(.lightText, for: .normal)
			signUpButton.isEnabled = false
			return
		}
		signUpButton.setTitleColor(.white, for: .normal)
		signUpButton.isEnabled = true
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
}
