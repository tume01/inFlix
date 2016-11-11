//
//  PosterViewController.swift
//  inFlix
//
//  Created by Franco Tume on 11/10/16.
//  Copyright © 2016 Franco Tume. All rights reserved.
//

import UIKit

class PosterViewController: UIViewController {
    
    var posterImage: UIImage? {
        didSet {
            setUpImage()
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpImage()
    }
    
    func setUpView() {
        view.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    }
    
    func setUpImage() {
        if let posterImageView = posterImageView {
             posterImageView.image = posterImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleRotate(_ sender: UIRotationGestureRecognizer) {
        if let imageView = sender.view {
            imageView.transform = imageView.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }

    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let imageView = sender.view {
            imageView.center = CGPoint(x:imageView.center.x + translation.x,
                                  y:imageView.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if let imageView = sender.view {
            imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PosterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
