//
//  SidebarViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 01/07/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import FirebaseAuth
import MMDrawerController
import MessageUI

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
	
	var menuItems : [String] = ["Home","Profile", "Share", "Send Feedback", "FAQ", "Logout"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let menuItemCell = tableView.dequeueReusableCell(withIdentifier: "SidebarMenuCell", for: indexPath) as! SidebarTableViewCell
		
		menuItemCell.itemNameLabel.text = menuItems[indexPath.row]
		
		return menuItemCell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		switch (indexPath.row) {
		//Home
		case 0:
			let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarId") as! UITabBarController
			
			let userProfileNavController = UINavigationController(rootViewController: userProfileViewController)
			
			let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
			
			appDelegate.centerContainer?.centerViewController = userProfileNavController
			appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
			
			break
		
		//Profile
		case 1:
			let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
			
			let userProfileNavController = UINavigationController(rootViewController: userProfileViewController)
			
			let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
			
			appDelegate.centerContainer?.centerViewController = userProfileNavController
			appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
			break
		
		//Share
		case 2:
			share()
			break
		
		//Send Feedback
		case 3:
			print("feedback clicked")
			sendFeedback()
			break
		
		//FAQ
		case 4:
			let faqViewController = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
			
			let faqNavController = UINavigationController(rootViewController: faqViewController)
			
			let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
			
			appDelegate.centerContainer?.centerViewController = faqNavController
			appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)

			break
			
		//Logout
		case 5:
			do {
				try Auth.auth().signOut()
			} catch let logOutError {
				print(logOutError)
			}

			let storyboard = UIStoryboard(name: "Start", bundle: nil)
			let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
			self.present(signInVC, animated: true, completion: nil)
			break
			
		default:
			print("nothing!!")
		}
	}
	

	
	
	//MARK : Share options
	func share(){
		let optionMenu = UIAlertController(title: nil, message: "Share on", preferredStyle: .actionSheet)
		
		let whatsapp = UIAlertAction(title: "Whatsapp", style: .default, handler: {
			(alert: UIAlertAction!) -> Void in
			
			self.whatsappFunction()
			
			
		})
		let facebook = UIAlertAction(title: "Facebook", style: .default, handler: {
			(alert: UIAlertAction!) -> Void in
			
		})
		
		let googlePlus = UIAlertAction(title: "Google+", style: .default, handler: {
			(alert: UIAlertAction!) -> Void in
			
		})
		
		let linkedIn = UIAlertAction(title: "Linkedin", style: .default, handler: {
			(alert: UIAlertAction!) -> Void in
			
		})
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
			(alert: UIAlertAction!) -> Void in
			
		})
		
		
		optionMenu.addAction(whatsapp)
		optionMenu.addAction(facebook)
		optionMenu.addAction(googlePlus)
		optionMenu.addAction(linkedIn)
		optionMenu.addAction(cancelAction)
		
		self.present(optionMenu, animated: true, completion: nil)
	}

	func whatsappFunction(){
		let vc = UIActivityViewController(activityItems: ["Hello"], applicationActivities: nil)
		self.present(vc, animated: true, completion: nil)
	}
	
	//MARK: Feedback
	func sendFeedback(){
		if MFMailComposeViewController.canSendMail() {
			let mail = MFMailComposeViewController()
			mail.mailComposeDelegate = self
			mail.setToRecipients(["contact@fitnytech.com"])
			mail.setSubject("Support App")
			mail.setMessageBody("<p>Send us your issue!</p>", isHTML: true)
			present(mail, animated: true, completion: nil)
		} else {
			// show failure alert
		}
	}
	
	func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: Error?,_: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}

}
