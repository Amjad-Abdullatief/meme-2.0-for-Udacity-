//
//  DetailViewController.swift
//  meme 1.0
//
//  Created by AMJAD - on 13/02/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme!
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImage.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
