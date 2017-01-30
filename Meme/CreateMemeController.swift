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
        topTextView.delegate = self
        bottomTextView.delegate = self
        
        setUpTextViews(font: "HelveticaNeue-CondensedBlack")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        present(pickerController, animated: true, completion: nil)
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
        setUpTextViews(font: font)
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
        view.endEditing(true)
        return false
    }
    @IBAction func shareButtonClicked(_ sender: UIBarButtonItem) {
        memeImageToShare = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memeImageToShare], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = completionHandler
    }
    
    func setUpTextViews(font: String) {
        configureTextField(textField: topTextView, font: font)
        configureTextField(textField: bottomTextView, font: font)
    }
    
    func configureTextField(textField: UITextField, font: String) {
        textField.defaultTextAttributes = getMemeTextAttributes(fontName: font)
        textField.textAlignment = NSTextAlignment.center
    }
}
