//
//  WorkoutsViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 28/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SDWebImage
import FirebaseUI
import FirebaseDatabase


class WorkoutsViewController: UIViewController {

	@IBOutlet weak var workoutTableView: UITableView!
	
	var workoutData = [WorkoutsData]()
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		workoutTableView.dataSource = self
		
		workoutTableView.rowHeight = UITableViewAutomaticDimension
		workoutTableView.estimatedRowHeight = 140
		
		loadWorkoutsData()
		
	
    }
	
	func loadWorkoutsData() {
		Database.database().reference().child("Workouts").observe(.childAdded) { (snapshot: DataSnapshot) in
			if let workoutsDataDict = snapshot.value as? [String : Any] {
				
				let imageDetails = workoutsDataDict["imageCaption"] as! String
				let data = WorkoutsData(imageDetailsString: imageDetails)
				self.workoutData.append(data)
				self.workoutTableView.reloadData()
			}
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
			self?.workoutTableView.reloadData()
		}
	}
	
	@IBAction func logOutButtonClicked(_ sender: Any) {
	
		logout()
	
	}
	
	func logout(){
		do {
			try Auth.auth().signOut()
		} catch let logOutError {
			print(logOutError)
		}
		
		let storyboard = UIStoryboard(name: "Start", bundle: nil)
		let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
		self.present(signInVC, animated: true, completion: nil)
	}
	

}

extension WorkoutsViewController : UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workoutData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CellForWorkout", for: indexPath) as! WorkoutTableViewCell
		
		var workoutImages : [StorageReference] = []
		
		for i in 1...workoutData.count {
			let ref = Storage.storage().reference().child("Workouts/\(i).jpg")
			workoutImages.append(ref)
		}
		
		cell.workoutImageView.sd_setImage(with: workoutImages[indexPath.row])
		
		cell.workoutNameLabel.text = workoutData[indexPath.row].imageDetails

		cell.workoutNameLabel.textColor = UIColor.darkGray
		cell.workoutNameLabel.textAlignment = .center
		cell.selectionStyle = .none
		
		cell.workoutNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		
		return cell
	}
}
