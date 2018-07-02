//
//  LogsViewController.swift
//  FitnyTech
//
//  Created by Rahul Ravi Prakash on 28/06/18.
//  Copyright © 2018 Rahul Ravi Prakash. All rights reserved.
//

import UIKit
import JTAppleCalendar

class LogsViewController: UIViewController {
	
	@IBOutlet weak var calendarView: JTAppleCalendarView!
	@IBOutlet weak var monthLabel : UILabel!
	@IBOutlet weak var yearLabel : UILabel!
	
	let formatter = DateFormatter()
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpCalendarView()
    }
	
	func setUpCalendarView() {
		calendarView.minimumLineSpacing = 0
		calendarView.minimumInteritemSpacing = 0
		
		
	}
	
	
	func handleSelectedCell(cell: JTAppleCell?, cellState: CellState){
		guard let selectedDate = cell as? CalendarCell else {return}
		if cellState.isSelected {
			selectedDate.selectedView.isHidden = false
		}
		else {
			selectedDate.selectedView.isHidden = true
		}
	}
	
	func handleSelectedCellTextColor(cell: JTAppleCell?, cellState: CellState){
		guard let selectedDate = cell as? CalendarCell else {return}
		
		if cellState.isSelected {
			selectedDate.datelabel.textColor = .black
		}
		else {
			if cellState.dateBelongsTo == .thisMonth {
				selectedDate.datelabel.textColor = .white
			}
			else {
				selectedDate.datelabel.textColor = .lightGray
				selectedDate.datelabel.isEnabled = false
			}
		}
	}


}

extension LogsViewController : JTAppleCalendarViewDataSource {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		//
	}
	
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		formatter.locale = Calendar.current.locale
		
		let startDate = formatter.date(from: "2018 06 01")!
		let endDate = formatter.date(from: "2018 12 31")!
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
		
		return parameters
	}
	
	
}

extension LogsViewController : JTAppleCalendarViewDelegate {
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		//
		let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
		
		cell.datelabel.text = cellState.text
		
		handleSelectedCell(cell: cell, cellState: cellState)
		handleSelectedCellTextColor(cell: cell, cellState: cellState)
		
		return cell
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		handleSelectedCell(cell: cell, cellState: cellState)
		
		handleSelectedCellTextColor(cell: cell, cellState: cellState)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		handleSelectedCell(cell: cell, cellState: cellState)
		
		handleSelectedCellTextColor(cell: cell, cellState: cellState)
	}
}


/* han wo aankhe jinhe main chumta tha bewajah
pyar mere liye kyu unme baki na raha*/
