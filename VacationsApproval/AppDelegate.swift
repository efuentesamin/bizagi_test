//
//  AppDelegate.swift
//  VacationsApproval
//
//  Created by Edwin Fuentes Amin on 2/20/16.
//  Copyright © 2016 efuentesamin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var navigationController: UINavigationController!


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		self.navigationController = application.windows[0].rootViewController as! UINavigationController
		return true
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		self.loadTasks()
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
	func loadTasks() {
		//Url for GET request
		let URL: NSString = "https://sheetsu.com/apis/v1.0/3c53eef9"
		
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		HTTPClient.request(URL, method: "GET", body: "", callback: {
			(resultObject: AnyObject?, error: Bool, errorMessage: NSString) -> Void in
			
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			
			if error == false {
				//There is no error. Process data
				taskManager.tasks = [Task]()
				for item in resultObject as! NSArray {
					taskManager.addTask(Task(values: item as! NSDictionary))
				}
				
				let mainViewController = self.navigationController.viewControllers[0] as! MainViewController
				mainViewController.tasksTable.reloadData()
			} else {
				//There was an error. Show the corresponding message
				let alertController = UIAlertController(title: "Error", message: errorMessage as String, preferredStyle: UIAlertControllerStyle.Alert)
				alertController.addAction(UIAlertAction(title: NSLocalizedString("OK_LABEL", comment: ""), style: UIAlertActionStyle.Default, handler: nil))
				self.navigationController.presentViewController(alertController, animated: true, completion: nil)
			}
		})
	}


}

