//
//  PreviewViewController.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 09.11.2022.
//

import UIKit
import SpringAnimation


class PreviewViewController: UIViewController {
  
    @IBOutlet var firstMazeImageView: SpringImageView!
    @IBOutlet var secondMazeImageView: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstMazeImageView.animation = "slideRight"
        firstMazeImageView.curve = "easeIn"
        firstMazeImageView.duration = 1.4
        firstMazeImageView.delay = 0.3
        firstMazeImageView.animate()
        
        secondMazeImageView.animation = "slideLeft"
        secondMazeImageView.curve = "easeIn"
        secondMazeImageView.duration = 1.4
        secondMazeImageView.delay = 0.3
        secondMazeImageView.animate()
    }
    
   
    

  

}
