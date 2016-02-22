//
//  Task.swift
//  VacationsApproval
//
//  Created by Edwin Fuentes Amin on 2/21/16.
//  Copyright © 2016 efuentesamin. All rights reserved.
//

import Foundation


class Task {
	
	var id: NSInteger
	var name: NSString
	var profilePhoto: NSString?
	var notes: NSString?
	var initDate: NSString
	var endDate: NSString
	var numDays: NSInteger
	var destination: NSString?
	var approved: NSString
	var loading: Bool
	
	init(values: NSDictionary) {
		self.id = (values.valueForKey("id") as! NSString).integerValue
		self.name = values.valueForKey("name") as! NSString
		self.profilePhoto = values.valueForKey("profile_photo") as? NSString
		self.notes = values.valueForKey("notes") as? NSString
		self.initDate = values.valueForKey("init_date") as! NSString
		self.endDate = values.valueForKey("end_date") as! NSString
		self.numDays = (values.valueForKey("days") as! NSString).integerValue
		self.destination = values.valueForKey("destination") as? NSString
		self.approved = values.valueForKey("approved") as! NSString
		self.loading = false
	}
}

