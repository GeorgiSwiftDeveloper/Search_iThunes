//
//  CreatPlaylistsViewController.swift
//  iTunes_Search
//
//  Created by Georgi Malkhasyan on 5/30/20.
//  Copyright © 2020 Malkhasyan. All rights reserved.
//

import UIKit

class CreatPlaylistsViewController: UIViewController {

    @IBOutlet weak var playlistTableView: UITableView!
    
    var createdPlaylistArray = ["New Playlist"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
    }
    

 

}

extension CreatPlaylistsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return createdPlaylistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath) as? PlaylistsTableViewCell {
            if indexPath.row == 0 {
                cell.playlistName.text = createdPlaylistArray[0]
                cell.playlistName.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                cell.playlistImage.image = UIImage(systemName: "list.bullet")
            }else{
                cell.playlistName.text = createdPlaylistArray[indexPath.row]
                cell.playlistName.textColor = UIColor.black
                cell.playlistName.font = UIFont(name: "Verdana", size: 12.0)
                cell.playlistName.textAlignment = .left
                cell.playlistImage.image = UIImage(systemName: "music.note.list")
            }
             return cell
        }else {
            return PlaylistsTableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            var playlistTxt = UITextField()
            let alert = UIAlertController(title: "New Playlist", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            let createPlaylistAction = UIAlertAction(title: "Create", style: .default) { (action) in
                let text = (alert.textFields?.first as! UITextField).text
                self.createdPlaylistArray.append(text!)
                print(self.createdPlaylistArray.count)
                self.playlistTableView.reloadData()
            }
            
            alert.addAction(action)
            alert.addAction(createPlaylistAction)
            //Add text field
             alert.addTextField { (texfield) in
                       playlistTxt = texfield
                       
                   }
            present(alert, animated: true, completion: nil)
        default:
            break
        }
    }
    
    
}