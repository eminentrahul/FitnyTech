//
//  ExerciseViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 28/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import FirebaseStorage
import SDWebImage
import FirebaseUI
import FirebaseDatabase
import MMDrawerController

class ExerciseViewController: UIViewController {

	@IBOutlet weak var exerciseTableView: UITableView!
	
	var exPosts = [ExerciseData]()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		exerciseTableView.dataSource = self
		
		exerciseTableView.rowHeight = UITableViewAutomaticDimension
		exerciseTableView.estimatedRowHeight = 140
		
		loadPost()

    }
	
	func loadPost() {
		Database.database().reference().child("Exercise").observe(.childAdded) { (snapshot: DataSnapshot) in
			if let exerciseDataDict = snapshot.value as? [String : Any] {
				
				let imageDetails = exerciseDataDict["imageCaption"] as! String
				let data = ExerciseData(imageDetailString: imageDetails)
				self.exPosts.append(data)
				self.exerciseTableView.reloadData()
			}
		}
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
			self?.exerciseTableView.reloadData()
		}
	}
	
	@IBAction func sideBarMenuButton(_ sender: UIBarButtonItem) {
		
		var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
		
		appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
	}
}

extension ExerciseViewController : UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return exPosts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellForExercise", for: indexPath) as! ExerciseTableViewCell
		
		var exerciseImage : [StorageReference] = []
		
		for i in 1...exPosts.count {
			let ref = Storage.storage().reference().child("Exercise/\(i).jpg")
			exerciseImage.append(ref)
		}
		
		cell.exerciseImageView.sd_setImage(with: exerciseImage[indexPath.row])
		
		cell.exerciseNameLabel.text = exPosts[indexPath.row].imageDetail
		
		cell.exerciseNameLabel.textColor = UIColor.darkGray
		cell.exerciseNameLabel.textAlignment = .center
		cell.selectionStyle = .none
		
		cell.exerciseNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		
		return cell
	}
	
	
}


