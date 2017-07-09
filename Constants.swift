//
//  Constants.swift
//  Flickr World Wildlife Day
//
//  Created by wealthyjalloh on 08/07/2017.
//  Copyright © 2017 CWJ. All rights reserved.
//

import Foundation


// MARK: Links and Docs

// Flickr API Docs
// https://www.flickr.com/services/api/

// World Wildlife Day galleries
// https://www.flickr.com/photos/flickr/galleries/72157677539266623/

// flickr.galleries.getPhotos
// https://www.flickr.com/services/api/flickr.galleries.getPhotos.html //


// full get galleries link
//  https://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&api_key=YOURKEY&gallery_id=72157677539266623&format=json&nojsoncallback=1&auth_token=72157683329763343-b1b1229db93edbf4&api_sig=05cf135ee202cc12694354f493653bce




// MARK: Constantss
struct Constants {
    
    // MARK: Flickr
    struct Flickr {
        static let APIBaseURL = " https://api.flickr.com/services/rest/"
    }
    
    
    struct FlickrParameterKeys {
        static let Method = "method"
        static let APIKey = "api_key"
        static let GalleryID = "gallery_id"
        static let Extras = "extras"
        static let Format = "format"
        static let NoJSONCallback = "nojsoncallback"
    }
    
    struct FlickrParameterValues {
        static let API = "YOUR KEY"
        static let ResonseFormat = "json"
        static let DisableJSONCallbacl = "1" // 1 means yes
        static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
        static let GalleryID = "72157677539266623"
        static let MediumURL = "url_m"
        
    }
    
    
    
}
