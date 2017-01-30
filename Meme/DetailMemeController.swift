//
//  DetailMemeController.swift
//  Meme
//
//  Created by Kushal Sharma on 30/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit

class DetailMemeController: UIViewController {

    var indexOfItem: Int?
    var memeStore: MemeStore? = nil
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeStore = MemeStore.sharedInstace
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image =  memeStore?.getMemeAtIndex(index: indexOfItem!).memedImage
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
