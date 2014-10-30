//
//  ViewController.swift
//  PhospheneDream
//
//  Created by Daniel Cloud on 10/30/14.
//  Copyright (c) 2014 Daniel Cloud. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var imageView: NSImageView! = NSImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "https://farm3.staticflickr.com/2922/14245216708_73f3c9ee09_b_d.jpg")
        let image:CIImage = CIImage(contentsOfURL: url)!

        let blurRadius = 5.0
        let overlayColor = NSColor(calibratedRed: 0.85, green: 0.513, blue: 0.130, alpha: 0.5)
        let blurredImage = blur(blurRadius)(image)

        let overlaidImage = colorOverlay(overlayColor)(image)

        let context = CIContext()
        let cgimg = context.createCGImage(overlaidImage, fromRect: overlaidImage.extent())

        if let cgimg = cgimg {
            let imageExtent = overlaidImage.extent()
            self.imageView.image = NSImage(CGImage: cgimg, size: imageExtent.size)
            self.view.addSubview(imageView)
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

