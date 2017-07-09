//
//  ViewController.swift
//  Flickr World Wildlife Day
//
//  Created by codewithjalloh on 08/07/2017.
//  Copyright © 2017 CWJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var getImageButton: UIButton!
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: Actions
    @IBAction func getNewImage(_ sender: AnyObject) {
        
        
    }
    
    
    
    // MARK: Configure The UI
    private func setUIEnable(trueOrFalse enabled: Bool) {
        nameTitleLabel.isEnabled = enabled
        getImageButton.isEnabled = enabled
        
        if enabled {
            // get button alpha 100% visible
            getImageButton.alpha = 1.0
        } else {
            // get button alpha 50% visible
            getImageButton.alpha = 0.5
        }
    }
    
    // MARK: Make Network Request
    private func getImageFromFlickr() {
        
    }
    
    

}

