//
//  AppDelegate.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 28/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

	var window: UIWindow?
	
	var centerContainer: MMDrawerController?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		//Change the coloor of the tab bar items
		UITabBar.appearance().tintColor = .black
		
		FirebaseApp.configure()
		
		GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
		GIDSignIn.sharedInstance().delegate = self
		
		_ = self.window!.rootViewController
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		
		let centerViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarId") as! UITabBarController
		
		let leftViewController = mainStoryboard.instantiateViewController(withIdentifier: "SidebarViewController") as! SidebarViewController
		
		_ = UINavigationController(rootViewController: leftViewController)
		_ = UINavigationController(rootViewController: centerViewController)
		
		centerContainer = MMDrawerController(center: centerViewController, leftDrawerViewController: leftViewController)
		
		centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView;
		centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView;
		window!.rootViewController = centerContainer
		window!.makeKeyAndVisible()
		
		return true
	}
	
	@available(iOS 9.0, *)
	func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
		-> Bool {
			return GIDSignIn.sharedInstance().handle(url,
													 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
													 annotation: options [UIApplicationOpenURLOptionsKey.annotation])
	}
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
		// ...
		if let error = error {
			// ...
			print("\(error.localizedDescription)")
			
			return
		}
		print("Successfully logged in Google", user)
		guard let authentication = user.authentication else { return }
		let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
													   accessToken: authentication.accessToken)
		Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
			if let error = error {
				// ...
				print("Failed to login in Firebase.", error)
				return
			}
			// User is signed in
			// ...
			print("Successfully logged in to Firebase.", user.userID)
			
			
			self.login()
			ProgressHUD.dismiss()
			
		}
	}
	
	func login () {
		NotificationCenter.default.post(
			name: Notification.Name("SuccessfulSignInNotification"), object: nil, userInfo: nil)
	}
	
	
	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
		// Perform any operations when the user disconnects from app here.
		// ...
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

