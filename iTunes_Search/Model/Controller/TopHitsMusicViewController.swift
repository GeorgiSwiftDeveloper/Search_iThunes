//
//  TopHitsMusicViewController.swift
//  iTunes_Search
//
//  Created by Georgi Malkhasyan on 4/28/20.
//  Copyright © 2020 Malkhasyan. All rights reserved.
//

import UIKit
import CoreData
import WebKit
import  YoutubePlayer_in_WKWebView

class TopHitsMusicViewController: UIViewController {
    
    var topHitsLists = [Video]()
    var myLibraryList = [Video]()
    var checkTable = Bool()
    
    var genreVideoID: String?
    var webView = WKYTPlayerView()
    
    @IBOutlet weak var topHitsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topHitsListTableView.delegate = self
        self.topHitsListTableView.dataSource = self
        if checkTable == false{
            fetchTopHitList()
        }else{
            fetchMyLibraryList()
        }
    }
    
    
    func fetchTopHitList(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TopHitsModel")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject] {
                let videoId = data.value(forKey: "videoId") as? String ?? ""
                let title = data.value(forKey: "title") as? String ?? ""
                let songDescription = data.value(forKey: "songDescription") as? String ?? ""
                let playListId = data.value(forKey: "playListId") as? String ?? ""
                let image = data.value(forKey: "image") as? String ?? ""
                let channelId = data.value(forKey: "channelId") as? String ?? ""
                let videoList = Video(videoId: videoId, videoTitle: title , videoDescription: songDescription , videoPlaylistId: playListId, videoImageUrl: image , channelId:channelId, genreTitle: "")
                
                
                topHitsLists.append(videoList)
                topHitsListTableView.reloadData()
            }
            
        } catch {
            print("Failed")
        }
    }
    
    
    func fetchMyLibraryList(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyLibraryMusicData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context?.fetch(request)
            for data in result as! [NSManagedObject] {
                let videoId = data.value(forKey: "videoId") as? String ?? ""
                let title = data.value(forKey: "title") as? String ?? ""
                let songDescription = data.value(forKey: "songDescription") as? String ?? ""
                let playListId = data.value(forKey: "playListId") as? String ?? ""
                let image = data.value(forKey: "image") as? String ?? ""
                let genreTitle = data.value(forKey: "genreTitle") as? String ?? ""
                let videoList = Video(videoId: videoId, videoTitle: title , videoDescription: songDescription , videoPlaylistId: playListId, videoImageUrl: image , channelId:"", genreTitle: genreTitle)
                
                
                myLibraryList.append(videoList)
                topHitsListTableView.reloadData()
            }
            
        } catch {
            print("Failed")
        }
    }
}

extension TopHitsMusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowsInSection = 0
        switch checkTable {
        case false:
            numberOfRowsInSection = topHitsLists.count
        case true:
            numberOfRowsInSection = myLibraryList.count
        }
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch checkTable {
        case false:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "topHitsCell", for: indexPath) as? TopHitsListTableViewCell {
                cell.configureTopHitsCell(topHitsLists[indexPath.row])
                return cell
            }else {
                return TopHitsListTableViewCell()
            }
        case true:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "topHitsCell", for: indexPath) as? TopHitsListTableViewCell {
                cell.configureMyLibraryCell(myLibraryList[indexPath.row])
                cell.addToFavoriteButton.isHidden = true
                return cell
            }else {
                return TopHitsListTableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch checkTable {
        case true:
            let selectedVideoId = myLibraryList[indexPath.row]
            webView.load(withVideoId: "")
            let sellectedCell = self.topHitsListTableView.cellForRow(at: indexPath) as! TopHitsListTableViewCell
            genreVideoID = selectedVideoId.videoId
            
            VideoPlayerClass.callVideoPlayer.superViewController = self
            VideoPlayerClass.callVideoPlayer.videoPalyerClass(sellectedCell: sellectedCell, genreVideoID: genreVideoID!, superView: self, ifCellIsSelected: true, selectedVideo: selectedVideoId)
        case false:
            let selectedVideoId = topHitsLists[indexPath.row]
            webView.load(withVideoId: "")
            let sellectedCell = self.topHitsListTableView.cellForRow(at: indexPath) as! TopHitsListTableViewCell
            genreVideoID = selectedVideoId.videoId
            
            VideoPlayerClass.callVideoPlayer.superViewController = self
            VideoPlayerClass.callVideoPlayer.videoPalyerClass(sellectedCell: sellectedCell, genreVideoID: genreVideoID!, superView: self, ifCellIsSelected: true, selectedVideo: selectedVideoId)
        }
    }
}
