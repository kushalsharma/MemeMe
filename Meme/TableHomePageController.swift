//
//  ViewController.swift
//  Meme
//
//  Created by Kushal Sharma on 27/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import UIKit

class TableHomePageController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellReuseIdentifier = "memeCell"
    
    @IBOutlet weak var myTableView: UITableView!
    
    var memeStore: MemeStore? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        memeStore = MemeStore.sharedInstace
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createMeme", sender: nil)
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (memeStore?.getAllSavedMemes().count)!
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MemeTableViewCell else {
            fatalError("The cell is not an instance of MemeTableViewCell")
        }
        cell.memImageView.image = memeStore?.getMemeAtIndex(index: indexPath.row).memedImage
        cell.decriptionLabel?.text = (memeStore?.getMemeAtIndex(index: indexPath.row).topText)! + " ... " + (memeStore?.getMemeAtIndex(index: indexPath.row).bottomText)!
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        let destinationVC = DetailMemeController()
        destinationVC.indexOfItem = index
        
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}

