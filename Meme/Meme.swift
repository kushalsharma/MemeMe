//
//  Meme.swift
//  Meme
//
//  Created by Kushal Sharma on 27/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
