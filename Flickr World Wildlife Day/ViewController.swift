//
//  ViewController.swift
//  Flickr World Wildlife Day
//
//  Created by codewithjalloh on 08/07/2017.
//  Copyright © 2017 CWJ. All rights reserved.

// full get galleries link
//  https://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=YOURKEY&gallery_id=72157677539266623&format=json&nojsoncallback=1&auth_token=72157683329763343-b1b1229db93edbf4&api_sig=05cf135ee202cc12694354f493653bce


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
        // call the setUIEnable and getImageFromFlickr func
        setUIEnable(trueOrFalse: false)
        getImageFromFlickr()
        
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
        
        let methodParameters = [
            // Call from the Constants.swift file
            Constants.FlickrParameterKeys.Method : Constants.FlickrParameterValues.GalleryPhotosMethod,
            Constants.FlickrParameterKeys.APIKey : Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.GalleryID : Constants.FlickrParameterValues.GalleryID,
            Constants.FlickrParameterKeys.Extras : Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.Format : Constants.FlickrParameterValues.ResonseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback : Constants.FlickrParameterValues.DisableJSONCallbacl
        ]
        
        // create url and request
        let session = URLSession.shared
        let urlString = Constants.Flickr.APIBaseURL + escapedParameters(methodParameters as [String:AnyObject])
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        
        // create network request
        let task = session.dataTask(with: request) { (data, response, error) in
            
        }
        
        
        
        
        // select a random animal photo
        let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
        let photoDictionary = photoArray[randomPhotoIndex] as [String:AnyObject]
        let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
        
        
        
        
        
    }
    
    
    // MARK: Helper for escaping Parameters in URL
    private func escapedParameters(_ parameters: [String: AnyObject]) -> String {
        
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                
                
                let stringValue = "\(value)"
                
                // escape
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
        
        
    }
    

}

