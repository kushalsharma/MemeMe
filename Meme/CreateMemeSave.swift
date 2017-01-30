//
//  CreateMemeSave.swift
//  Meme
//
//  Created by Kushal Sharma on 27/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

extension CreateMemeController {
    func completionHandler(activityType: UIActivityType?, shared: Bool, items: [Any]?, error: Error?) {
        if (shared) {
            save(image: memeImageToShare)
        }
    }
    
    func save(image: UIImage) {
        // Create the meme
        let meme = Meme(topText: topTextView.text!, bottomText: bottomTextView.text!, originalImage: photoImageView.image!, memedImage: image)
        MemeStore.sharedInstace.saveMeme(newMeme: meme)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navigation
        toolbar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navigation
        toolbar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        return memedImage
    }
}
