//
//  TableViewController.swift
//  MusicPlayer_iOS
//
//  Created by Lobler Ádám on 2017. 10. 29..
//  Copyright © 2017. Lobler Ádám. All rights reserved.
//

import UIKit
import MediaPlayer


class MusicLibraryController: UITableViewController {
    
    @IBOutlet weak var navigationbarOutlet: UINavigationBar!
    private var MusicDataManager: musicDataManager?
    var currentSong = MPMediaItem()
    
    @IBAction func backbuttonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as? AppDelegate)?.MusicDataManager.query = MPMediaQuery.songs()
        MusicDataManager = (UIApplication.shared.delegate as? AppDelegate)?.MusicDataManager
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (MusicDataManager?.songs.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let songData = MusicDataManager!.songs[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = songData.title
        cell.detailTextLabel?.text = songData.albumArtist
        cell.imageView?.image = songData.artwork?.image(at: CGSize(width: 200, height: 200))!
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let row = tableView.indexPathForSelectedRow?.row
        currentSong = (MusicDataManager?.songs[row!])!
        
        
    }
    
    
}
