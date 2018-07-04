//
//  FAQViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 02/07/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.

import UIKit
import FAQView

class FAQViewController: UIViewController {
	
	var faqView: FAQView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "FAQs"
		//let rightBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
		//navigationItem.leftBarButtonItem = rightBarButton
		
		self.automaticallyAdjustsScrollViewInsets = false
		
		let items = [FAQItem(question: "Which is better for your body and why: yoga or Pilates?", answer: "That really depends—it's a personal thing. If you have lower back issues, I don't advise yoga because of the stress on your lower back in some of the positions. Yoga is great for stretching, and Pilates is better for strengthening your entire body."), FAQItem(question: "What are the biggest mistakes people make at the gym?", answer: "The biggest mistake people make at the gym is not understanding how to use the equipment. They perform exercises improperly and end up injuring themselves. So don't be afraid to ask a professional how to use the equipment! [And while you're at it, be sure to steer clear of these 10 exercise machines to avoid!] "), FAQItem(question: "Do you have any exercises I could do at my desk to burn some extra calories without bothering my co-workers?", answer: "If you're able to do squats or other legwork options while at your office chair, try them! You can hold onto your chair and try squats, or you can sit at your desk, squeeze your glutes, and kick your leg out for quad extensions. Or get clever: If you drop something at the office, instead of bending down to pick it up, try a squat. Also, don't be afraid to get out of your cubicle and take the long way to the bathroom.")]
		faqView = FAQView(frame: view.frame, items: items)
		faqView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(faqView)
		addFaqViewConstraints()
	}
	
	func addFaqViewConstraints() {
		let faqViewTrailing = NSLayoutConstraint(item: faqView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 17)
		let faqViewLeading = NSLayoutConstraint(item: faqView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: -17)
		let faqViewTop = NSLayoutConstraint(item: faqView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 50)
		let faqViewBottom = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: faqView, attribute: .bottom, multiplier: 1, constant: 0)
		
		NSLayoutConstraint.activate([faqViewTop, faqViewBottom, faqViewLeading, faqViewTrailing])
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}
