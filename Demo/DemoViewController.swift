//
//  DemoViewController.swift
//  What Color Is It
//
//  Created by Sam Soffes on 7/19/15.
//  Copyright © 2015 Sam Soffes. All rights reserved.
//

import AppKit
import ScreenSaver

class DemoViewController: NSViewController {

	// MARK: - Properties

	let screenSaver: ScreenSaverView = {
		let view = View()
		view.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
		return view
	}()


	// MARK: - NSViewController

	override func viewDidLoad() {
		// Add the clock view to the window
		screenSaver.frame = view.bounds
		view.addSubview(screenSaver)

		// Start animating the clock
		screenSaver.startAnimation()
		NSTimer.scheduledTimerWithTimeInterval(screenSaver.animationTimeInterval, target: screenSaver, selector: "animateOneFrame", userInfo: nil, repeats: true)
	}
}
