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
            
            // if an error occurs, print it and re-enable the UI
            func displayError(print error: String) {
                print(error)
                print("URL at time of error: \(url)")
                
                performNetworkMainUpdate {
                    self.setUIEnable(trueOrFalse: true)
                }
            }
            
            // GUARD: was there an error?
            guard (error == nil) else {
                displayError(print: "There was an error with your request \(error!)")
                return
            }
            
            
            // GUARD: did we get a successful 2xx response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else  {
                
                displayError(print: "Your request returned a status code or other than 2xx!")
                return
            }
            
            
            // GUARD: was there any data returned?
            guard let data = data else {
                displayError(print: "No data was return by the request!")
                return
            }
            
            
            // parse the data
            let parsedResult: [String: AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
            }catch {
                
                displayError(print: "could not parse the data as JSON: '\(data)'")
                return
            }
            
            
            // GUARD: did Flickr return an erro (stat != ok)?
            guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String, stat == Constants.FlickrResponseValues.OKStatus else {
                displayError(print: "Flickr API returned an error. See error code and message in \(parsedResult)")
                return
            }
            
            
            // GUARD: Are the "photos" and "photo" keys in our result?
            guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String: AnyObject], let photoArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String:AnyObject]] else {
                displayError(print: "Cannot find keys '\(Constants.FlickrResponseKeys.Photos)' and '\(Constants.FlickrResponseKeys.Photo)' in \(parsedResult)")
                return
            }
            
            
            // select a random animal photo
            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
            let photoDictionary = photoArray[randomPhotoIndex] as [String:AnyObject]
            let photoTitle = photoDictionary[Constants.FlickrResponseKeys.Title] as? String
            
            
            
            // GUARD: Does our photo have a key for 'url_m'?
            guard let imageURLString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
                displayError(print: "Cannot find key '\(Constants.FlickrResponseKeys.MediumURL)' in \(photoDictionary)")
                return
            }
            
            
            // if an image exist at the url, set the image and title
            let imageURL = URL(string: imageURLString)
            if let imageData = try? Data(contentsOf: imageURL!) {
                performNetworkMainUpdate {
                    self.setUIEnable(trueOrFalse: true)
                    self.photoImageView.image = UIImage(data: imageData)
                    self.nameTitleLabel.text = photoTitle ?? "(Untitled)"
                }
            } else {
                displayError(print: "Image does not exist at \(imageURL!)")
            }
        }
        // start the task!
        task.resume()
        
        
        
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

