//
//  SentMemesColllectionVC.swift
//  meme 1.0
//
//  Created by AMJAD - on 13/02/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class SentMemesColllectionVC:  UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
//        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the image
        cell.MemeImage?.image = memes[indexPath.row].memedImage
        return cell
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailsView") as! DetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = self.memes[indexPath.row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

}
