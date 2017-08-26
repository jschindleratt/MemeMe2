//
//  MemeMeDetailViewController.swift
//  MemeMe2
//
//  Created by Joshua Schindler on 8/25/17.
//  Copyright © 2017 Joshua Schindler. All rights reserved.
//

import UIKit

class MemeMeDetailViewController: UIViewController {

    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets

    @IBOutlet var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
    }
}
