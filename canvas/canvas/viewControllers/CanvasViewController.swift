//
//  CanvasViewController.swift
//  canvas
//
//  Created by Diego Medina on 3/12/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

// TODO: STEP 5 and make sure it works lol

import UIKit

class CanvasViewController: UIViewController {
    
    // main view
    @IBOutlet weak var trayView: UIView!
    
    // faces view
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    // faces
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 260
        trayUp = trayView.center
        // The position of the tray transposed down
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
            let velocity = sender.velocity(in: view)
            
            if( velocity.y > 0 ){ //moving down
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayDown
                }
                
            }else{ // moving up
                
                UIView.animate(withDuration: 0.3) {
                    self.trayView.center = self.trayUp
                }
            }
            
        } // else if
        
    } // didPan
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanNewFace(sender:)))
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchFace(sender:)))
        
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotateFace(sender:)))
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapFace(sender:)))
        
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
 
        if sender.state == .began {
    
            let imageView = sender.view as! UIImageView

            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            newlyCreatedFace.isUserInteractionEnabled = true
//            newlyCreatedFace.isMultipleTouchEnabled = true
            
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(gestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(rotateGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(doubleTapGestureRecognizer)
            
        } else if sender.state == .changed {
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
        }
        
    } // didPanface
    
    @objc func didPanNewFace(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
        }

    } // didPanNewFace

    @objc func didPinchFace(sender: UIPinchGestureRecognizer) {
        
        let scale = sender.scale
        let imageView = sender.view as! UIImageView
        imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)
        sender.scale = 1
        
    } // didPinchFace
    
    @objc func didRotateFace(sender: UIRotationGestureRecognizer) {
        
        let rotation = sender.rotation
        let imageView = sender.view as! UIImageView
        imageView.transform = imageView.transform.rotated(by: rotation)
        sender.rotation = 0
        
    } // didPinchFace

    @objc func didDoubleTapFace(sender: UITapGestureRecognizer) {
        
        sender.view?.removeFromSuperview()
        
    } // didPinchFace
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
