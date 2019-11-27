//
//  MemeTableViewController.swift
//  meme 1.0
//
//  Created by AMJAD - on 13/02/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.ImageView.image = memes[indexPath.row].memedImage
        cell.Label.text = "\(memes[indexPath.row].topText)...\(memes[indexPath.row].bottomText)"
    
        tableView.rowHeight = 180
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailsView") as! DetailViewController
        detailVC.meme = self.memes[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}
