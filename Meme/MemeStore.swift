//
//  MemeStore.swift
//  Meme
//
//  Created by Kushal Sharma on 30/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation

class MemeStore {
    static let sharedInstace = MemeStore()
    
    private init() {}
    
    private var memes: [Meme] = []
    
    func saveMeme(newMeme: Meme) {
        memes += [newMeme]
    }
    
    func getAllSavedMemes() -> [Meme] {
        return memes
    }
    
    func getMemeAtIndex(index: Int) -> Meme {
        return memes[index]
    }
    
    func removeMemeAtIndex(index: Int) {
        memes.remove(at: index)
    }
    
    func overwriteMemeAtIndex(index: Int, withMeme meme: Meme) {
        memes[index] = meme
    }
}
