//
//  NewTaskViewController.swift
//  VacationsApproval
//
//  Created by Edwin Fuentes Amin on 2/22/16.
//  Copyright © 2016 efuentesamin. All rights reserved.
//

import UIKit


class NewTaskViewController: UIViewController, UITextFieldDelegate {
	
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var notesTextField: UITextField!
	@IBOutlet weak var initDateTextField: UITextField!
	@IBOutlet weak var endDateTextField: UITextField!
	@IBOutlet weak var destinationTextField: UITextField!
	@IBOutlet weak var saveButton: UIBarButtonItem!
	
	var task: Task!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	
	@IBAction func datePickerTapped(sender: AnyObject) {
		let textField = sender as! UITextField
		self.view.endEditing(true)
		textField.resignFirstResponder()
		DatePickerDialog().show("Fecha", doneButtonTitle: "Ok", cancelButtonTitle: "Cancelar", datePickerMode: UIDatePickerMode.Date) {
			(date) -> Void in
			textField.text = "\(date)"
		}
	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		let taskDictionary: NSMutableDictionary = NSMutableDictionary()
		
		if saveButton === sender {
			taskDictionary.setValue("\(taskManager.tasks.count + 1)", forKey: "id")
			taskDictionary.setValue(nameTextField.text, forKey: "name")
			taskDictionary.setValue(notesTextField.text, forKey: "notes")
			taskDictionary.setValue(initDateTextField.text, forKey: "init_date")
			taskDictionary.setValue(endDateTextField.text, forKey: "end_date")
			taskDictionary.setValue("0", forKey: "days")
			taskDictionary.setValue(destinationTextField.text, forKey: "destination")
			taskDictionary.setValue("no", forKey: "approved")
			
			self.task = Task(values: taskDictionary)
		}
	}
	
	
	@IBAction func cancel(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	
	@IBAction func editingEnd(sender: AnyObject) {
		let textField = sender as! UITextField
		textField.resignFirstResponder()
	}
	
}




