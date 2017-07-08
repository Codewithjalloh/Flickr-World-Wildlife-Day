//
//  BlackBox.swift
//  Flickr World Wildlife Day
//
//  Created by codewithjalloh on 08/07/2017.
//  Copyright © 2017 CWJ. All rights reserved.
//

import Foundation

// escaping closure
func performNetworkMainUpdate(_ updated: @escaping () -> Void) {
    
    // dispach the main queue using asynchronous
    DispatchQueue.main.async {
        updated()
    }
}
