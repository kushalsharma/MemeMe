//
//  CreateMemeController.swift
//  Meme
//
//  Created by Kushal Sharma on 27/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class CreateMemeController: UIViewController {
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = false
    }
    
    @IBAction func photoPickerClicked(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        switch sender.tag {
        case 0:
            pickerController.sourceType = .photoLibrary
            break
        case 1:
            pickerController.sourceType = .camera
            break
        default: break
        }
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }
}
