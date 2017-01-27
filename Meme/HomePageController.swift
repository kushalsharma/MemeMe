//
//  ViewController.swift
//  Meme
//
//  Created by Kushal Sharma on 27/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createMeme", sender: nil)
    }
    
}

