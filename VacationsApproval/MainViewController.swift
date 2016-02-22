//
//  ViewController.swift
//  VacationsApproval
//
//  Created by Edwin Fuentes Amin on 2/20/16.
//  Copyright © 2016 efuentesamin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	
	@IBOutlet weak var tasksTable: UITableView!

	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.tasksTable.tableFooterView = UIView(frame: CGRectZero)
	}
	
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	@IBAction func unwindToTasksList(sender: UIStoryboardSegue) {
		if let sourceViewController = sender.sourceViewController as? NewTaskViewController {
			let task = sourceViewController.task
			
			let newIndexPath = NSIndexPath(forRow: taskManager.tasks.count, inSection: 0)
			taskManager.addTask(task)
			self.tasksTable.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
			
			task.loading = true
			
			//Url for POST request
			let URL: NSString = "https://sheetsu.com/apis/v1.0/3c53eef9"
			
			//Construct http body string
			let body = String(format: "{\"id\": \"%d\", \"name\": \"%@\", \"notes\": \"%@\", \"days\": \"%d\", \"init_date\": \"%@\", \"end_date\": \"%@\", \"destination\": \"%@\", \"approved\": \"%@\"}",
				task.id, task.name, task.notes!, task.numDays, task.initDate, task.endDate, task.destination!, task.approved)
			
			UIApplication.sharedApplication().networkActivityIndicatorVisible = true
			HTTPClient.request(URL, method: "POST", body: body, callback: {
				(resultObject: AnyObject?, error: Bool, errorMessage: NSString) -> Void in
				
				task.loading = false
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
				
				if error == false {
					self.tasksTable.reloadData()
				} else {
					//There was an error. Show the corresponding message
					let alertController = UIAlertController(title: "Error", message: errorMessage as String, preferredStyle: UIAlertControllerStyle.Alert)
					alertController.addAction(UIAlertAction(title: NSLocalizedString("OK_LABEL", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
					self.navigationController!.presentViewController(alertController, animated: true, completion: nil)
				}
			})

		}
	}


	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return taskManager.tasks.count
	}
	
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CustomCell")! as UITableViewCell
		let profileImage = cell.viewWithTag(2) as! UIImageView
		let nameLabel = cell.viewWithTag(1) as! UILabel
		let notesLabel = cell.viewWithTag(3) as! UILabel
		let approvedImage = cell.viewWithTag(4) as! UIImageView
		
		let task = taskManager.tasks[indexPath.row]
		
		profileImage.layer.cornerRadius = profileImage.frame.size.width / 2;
		profileImage.clipsToBounds = true;
		profileImage.image = UIImage(named: "default_profile.jpeg")
		
		if let profilePhoto = task.profilePhoto {
			let cache = ImageLoadingWithCache()
			cache.getImage(profilePhoto as String, imageView: profileImage, defaultImage: "default_profile.jpeg")
		}
		
		nameLabel.text = task.name as String
		notesLabel.text = task.notes as? String
		
		if task.approved == "si" {
			approvedImage.image = UIImage(named: "approved.png")
		} else {
			approvedImage.image = UIImage(named: "unapproved.png")
		}
		
		return cell
	}
	
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		let task = taskManager.tasks[indexPath.row]
		
		var approved = "si"
		if task.approved == "si" {
			approved = "no"
		}
		
		task.approved = approved
		
		if task.loading == false {
			task.loading = true
			//Url for PATCH request
			let URL: NSString = String(format: "https://sheetsu.com/apis/v1.0/3c53eef9/id/%d", task.id)
			
			UIApplication.sharedApplication().networkActivityIndicatorVisible = true
			HTTPClient.request(URL, method: "PATCH", body: "{\"approved\": \"\(approved)\"}", callback: {
				(resultObject: AnyObject?, error: Bool, errorMessage: NSString) -> Void in
				
				task.loading = false
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
				
				if error == false {
					self.tasksTable.reloadData()
				} else {
					//There was an error. Show the corresponding message
					let alertController = UIAlertController(title: "Error", message: errorMessage as String, preferredStyle: UIAlertControllerStyle.Alert)
					alertController.addAction(UIAlertAction(title: NSLocalizedString("OK_LABEL", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
					self.navigationController!.presentViewController(alertController, animated: true, completion: nil)
				}
			})
		}

	}

}

