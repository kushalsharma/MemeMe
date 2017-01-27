//
//  CreateMemeController.swift
//  Meme
//
//  Created by Kushal Sharma on 27/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class CreateMemeController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var topTextView: UITextField!
    @IBOutlet weak var bottomTextView: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var shouldUpdateView: Bool = false
    var memeImageToShare: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        shareButton.isEnabled = false
        
        topTextView.defaultTextAttributes = getMemeTextAttributes(fontName: "HelveticaNeue-CondensedBlack")
        bottomTextView.defaultTextAttributes = getMemeTextAttributes(fontName: "HelveticaNeue-CondensedBlack")
        topTextView.textAlignment = NSTextAlignment.center
        bottomTextView.textAlignment = NSTextAlignment.center
        topTextView.delegate = self
        bottomTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    func getFontList() -> [String] {
        var fontNameList: [String] = []
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            let names = UIFont.fontNames(forFamilyName: familyName)
            for name in names {
                if ((name.contains("Heavy") || name.contains("Bold")) && !(name.contains("Semi") || name.contains("Italic"))) {
                    fontNameList.append(name)
                }
            }
        }
        return fontNameList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
        default:
            break
        }
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func fontsClicked(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 2:
            let alertController = UIAlertController(title: "Select Font", message: "", preferredStyle: .actionSheet)
            for font in getFontList(){
                alertController.addAction(UIAlertAction(title: font, style: .default, handler: fontSelected))
            }
            present(alertController, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func fontSelected(action: UIAlertAction) {
        let font: String = action.title!
        topTextView.defaultTextAttributes = getMemeTextAttributes(fontName: font)
        bottomTextView.defaultTextAttributes = getMemeTextAttributes(fontName: font)
        
        topTextView.textAlignment = NSTextAlignment.center
        bottomTextView.textAlignment = NSTextAlignment.center
    }
    
    func getMemeTextAttributes(fontName: String) -> [String: Any] {
        let memeTextAttributes:[String: Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: fontName, size: 40)!,
            NSStrokeWidthAttributeName: NSNumber(value: -4.0)
        ]
        return memeTextAttributes
    }
    
    @IBAction func topTextClicked(_ sender: UITextField) {
        shouldUpdateView = false
    }
    
    @IBAction func bottomTextClicked(_ sender: UITextField) {
        shouldUpdateView = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func shareButtonClicked(_ sender: UIBarButtonItem) {
        memeImageToShare = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memeImageToShare], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = completionHandler
    }
}
