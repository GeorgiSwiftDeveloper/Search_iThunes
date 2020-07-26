//
//  FavoriteSongsViewController.swift
//  iTunes_Search
//
//  Created by Georgi Malkhasyan on 4/4/20.
//  Copyright © 2020 Malkhasyan. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import YoutubePlayer_in_WKWebView
class GenresViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var navigationForMusic: UINavigationItem!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    var selectedGenreIndexRow = Int()
    var indexArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreCollectionView.isScrollEnabled = false
        self.genreCollectionView.delegate = self
        self.genreCollectionView.dataSource = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationIdentifierGenreRowSelected(notification:)), name: Notification.Name("NotificationIdentifierGenreRowSelected"), object: nil)
        let pause = UserDefaults.standard.object(forKey: "pause") as? Bool
        switch pause {
        case true:
            VideoPlayerClass.callVideoPlayer.superViewController = self
            self.view.addSubview(VideoPlayerClass.callVideoPlayer.cardViewController.view)
            VideoPlayerClass.callVideoPlayer.webView.getPlayerState({ [weak self] (playerState, error) in
                if let error = error {
                    print("Error getting player state:" + error.localizedDescription)
                } else if let playerState = playerState as? WKYTPlayerState {
                    
                    self?.updatePlayerState(playerState)
                }
            })
        case false:
            VideoPlayerClass.callVideoPlayer.superViewController = self
            self.view.addSubview(VideoPlayerClass.callVideoPlayer.cardViewController.view)
            VideoPlayerClass.callVideoPlayer.webView.getPlayerState({ [weak self] (playerState, error) in
                if let error = error {
                    print("Error getting player state:" + error.localizedDescription)
                } else if let playerState = playerState as? WKYTPlayerState {
                    
                    self?.updatePlayerState(playerState)
                }
            })
        default:
            break
        }
         self.navigationController?.navigationBar.isHidden = true
    }
    
    func updatePlayerState(_ playerState: WKYTPlayerState){
        switch playerState {
        case .ended:
            self.showVideoPlayerPause()
        case .paused:
            self.showVideoPlayerPause()
            
        case .playing:
            self.showVideoPlayer()
        default:
            break
        }
    }
    
    
    func showVideoPlayer(){
        VideoPlayerClass.callVideoPlayer.webView.playVideo()
    }
    func showVideoPlayerPause(){
        VideoPlayerClass.callVideoPlayer.webView.pauseVideo()
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        VideoPlayerClass.callVideoPlayer.cardViewController.removeFromParent()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  GenreModelService.instance.getGenreArray().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCollectionCell", for: indexPath) as? GenresCollectionViewCell {
                cell.confiigurationCell(GenreModelService.instance.getGenreArray()[indexPath.row])
                cell.trackCountLabel.text = ""
                UserDefaults.standard.set(indexPath.row, forKey:"selectedGenereCollectionIndex")
                indexArray.append(indexPath.row)
                return cell
            }else {
                return GenresCollectionViewCell()
            }
    }
    
    @objc func NotificationIdentifierGenreRowSelected(notification: Notification) {
        UserDefaults.standard.set(selectedGenreIndexRow, forKey:"selectedGenereCollectionIndex")
    }
    
    
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "genrseListSegue" {
            let genreVC = segue.destination as! GenreListViewController
            let selectedSearch = UserDefaults.standard.object(forKey: "selectedSearch") as? Bool
            if selectedSearch == true {
                genreVC.searchIsSelected = true
            }
            
            let selectedmyLybrary = UserDefaults.standard.object(forKey: "selectedmyLybrary") as? Bool
            if selectedmyLybrary == true {
                genreVC.selectedmyLybrary = true
            }
            genreVC.genreModel  = sender as? GenreModel
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedGenreRow = GenreModelService.instance.getGenreArray()[indexPath.row]
            selectedGenreIndexRow = indexPath.row
            
            let selectedGenereCollectionIndex = UserDefaults.standard.object(forKey: "selectedGenereCollectionIndex") as? Int
            if selectedGenereCollectionIndex == selectedGenreIndexRow {
                UserDefaults.standard.set(true, forKey:"checkGenreRowIsSelected")
            }else{
                UserDefaults.standard.set(false, forKey:"checkGenreRowIsSelected")
            }
            
            self.performSegue(withIdentifier: "genrseListSegue", sender: selectedGenreRow)
    }
}
