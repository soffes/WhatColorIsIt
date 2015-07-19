//
//  AppDelegate.swift
//  WhatColorIsIt
//
//  Created by Sam Soffes on 7/15/14.
//  Copyright (c) 2014 Sam Soffes. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	// MARK: - Properties

	@IBOutlet var window: NSWindow!


	// MARK: - Initializers

	deinit {
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}
}


extension AppDelegate: NSWindowDelegate {
	func windowWillClose(notification: NSNotification) {
		// Quit the app if the main window is closed
		NSApplication.sharedApplication().terminate(window)
	}
}
