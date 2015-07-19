//
//  View.swift
//  What Color Is It
//
//  Created by Sam Soffes on 7/17/15.
//  Copyright © 2015 Sam Soffes. All rights reserved.
//

import AppKit
import ScreenSaver

public class View: ScreenSaverView {

	// MARK: - NSView

	public override func drawRect(rect: NSRect) {
		let comps = NSCalendar.currentCalendar().components([.Hour, .Minute, .Second], fromDate: NSDate())
		let red = pad(comps.hour)
		let green = pad(comps.minute)
		let blue = pad(comps.second)
		let color = NSColor(SRGBRed: hexValue(red), green: hexValue(green), blue: hexValue(blue), alpha: 1)

		color.setFill()
		NSBezierPath.fillRect(rect)

		let string = "#\(red)\(green)\(blue)" as NSString
		let attributes = [
			NSForegroundColorAttributeName: NSColor.whiteColor(),
			NSFontAttributeName: fontWithSize(rect.width / 6)
		]

		let stringSize = string.sizeWithAttributes(attributes)
		let stringRect = CGRect(
			x: round((bounds.width - stringSize.width) / 2),
			y: round((bounds.height - stringSize.height) / 2),
			width: stringSize.width,
			height: stringSize.height
		)
		string.drawInRect(stringRect, withAttributes: attributes)
	}


	// MARK: - ScreenSaverView

	public override init?(frame: NSRect, isPreview: Bool) {
		super.init(frame: frame, isPreview: isPreview)
		initialize()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		initialize()
	}

	public override func animateOneFrame() {
		setNeedsDisplayInRect(bounds)
	}


	// MARK: - Private

	private func initialize() {
		animationTimeInterval = 1.0 / 4.0
	}

	private func pad(integer: Int) -> String {
		var string = String(integer)
		if string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1 {
			string = "0" + string
		}
		return string
	}

	private func hexValue(string: String) -> CGFloat {
		let value = Double(strtoul(string, nil, 16))
		return CGFloat(value / 255.0)
	}

	private func fontWithSize(fontSize: CGFloat) -> NSFont {
		let font: NSFont
		if #available(OSX 10.11, *) {
			font = NSFont.systemFontOfSize(fontSize, weight: NSFontWeightThin)
		} else {
			font = NSFont(name: "HelveticaNeue-Thin", size: fontSize)!
		}

		let fontDescriptor = font.fontDescriptor.fontDescriptorByAddingAttributes([
			NSFontFeatureSettingsAttribute: [
				[
					NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
					NSFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
				]
			]
		])
		return NSFont(descriptor: fontDescriptor, size: fontSize)!
	}
}
