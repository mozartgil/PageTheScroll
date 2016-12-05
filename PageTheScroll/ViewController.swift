//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Mozart Gil on 2/12/16.
//  Copyright © 2016 Mozart Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageList = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        swipeRight.delegate = self
        swipeLeft.delegate = self
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    // **To have UIScrollView frame properties on load, we need to use it on viewDidAppear. It doesn't work on viewDidLoad**
    override func viewDidAppear(_ animated: Bool) {
        let imageWidth: CGFloat = 150
        let imageHeight: CGFloat = 150
        var imageXPos: CGFloat = 0.0
        var imageYPos: CGFloat = 0.0
        var contentWidth: CGFloat = 0.0
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            imageList.append(imageView)
            
            imageXPos = ((scrollView.frame.size.width / 2) - CGFloat(imageWidth / 2)) + scrollView.frame.size.width * CGFloat(x)
            imageYPos = (scrollView.frame.size.height / 2) - CGFloat(imageHeight / 2)
            
            // In the end of the loop, contentWidth is going to have the width of all images together
            contentWidth += imageXPos
            
            // This needs to come before imageView.frame
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: imageXPos, y: imageYPos, width: imageWidth, height: imageHeight)
        }
        
        // This propertie make the next image show up on screen. Dim the size of scrollView to work better. This propertie can be changed on Storyboard as well
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.size.height)
        
        // **gesture recognizer**
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}

