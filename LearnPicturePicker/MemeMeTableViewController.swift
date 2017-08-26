//
//  MemeMeTableViewController.swift
//  MemeMe2
//
//  Created by Joshua Schindler on 8/25/17.
//  Copyright © 2017 Joshua Schindler. All rights reserved.
//

import UIKit

class MemeMeTableViewController: UITableViewController {

    @IBOutlet var memeTVC: UITableView!
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sent Memes"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.imageView!.image = meme.memedImage
        cell.textLabel!.text = meme.topText + "..." + meme.bottomText
        //cell.detailLabel!.text = "testing detail"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeMeDetailViewController") as! MemeMeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func showSavedMemes() {
        let controller: MememeViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "MemeMeViewController") as! MememeViewController
        present(controller, animated: true, completion: nil)
    }
}
