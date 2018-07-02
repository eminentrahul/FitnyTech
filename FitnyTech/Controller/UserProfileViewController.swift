//
//  UserProfileViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 02/07/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
	@IBAction func logOutButtonClicked(_ sender: UIButton) {
		
		let logOut = WorkoutsViewController()
		logOut.logout()
		
	}
	
}
