//
//  CanvasViewController.swift
//  canvas
//
//  Created by Diego Medina on 3/12/18.
//  Copyright © 2018 Diego Medina. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
    
        let translation = sender.translation(in: view)

        if sender.state == .began {
            trayOriginalCenter = trayView.center
            
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            
            
        }
        
    }
    
    
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
