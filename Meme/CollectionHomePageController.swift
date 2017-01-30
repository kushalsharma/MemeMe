//
//  CollectionHomePageController.swift
//  Meme
//
//  Created by Kushal Sharma on 29/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import UIKit

class CollectionHomePageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "memeItemVIew"
    var memeStore: MemeStore? = nil
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        memeStore = MemeStore.sharedInstace
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (memeStore?.getAllSavedMemes().count)!
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MemeCollectionViewCell
        cell.memeImageView.image =  memeStore?.getMemeAtIndex(index: indexPath.row).memedImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails"){
            let destinationVC = segue.destination as! DetailMemeController
            destinationVC.indexOfItem = selectedRow
        }
    }
}

