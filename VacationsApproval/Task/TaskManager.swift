//
//  TaskManager.swift
//  VacationsApproval
//
//  Created by Edwin Fuentes Amin on 2/21/16.
//  Copyright © 2016 efuentesamin. All rights reserved.
//

import Foundation


var taskManager: TaskManager = TaskManager()


class TaskManager {
	
	var tasks = [Task]()
	
	
	func addTask(task: Task) {
		tasks.append(task)
	}
}

