//
//  AlbumModel.swift
//  iTunes_Search
//
//  Created by Georgi Malkhasyan on 3/31/20.
//  Copyright © 2020 Malkhasyan. All rights reserved.
//

import UIKit

class AlbumModel: NSObject {
    var videoId: String?
    var channelTitle: String?
    var imageUrl: String?
    var title: String?
//    var trackViewUrl: String?
//    var previewUrl: String?
//    var checkIfSelected: Bool?
    
    init(videoId: String, channelTitle:String, imageUrl:String,title:String) {
    
            self.videoId = videoId
            self.channelTitle = channelTitle
            self.imageUrl = imageUrl
            self.title = title
//            self.trackViewUrl = trackViewUrl
//            self.previewUrl = previewUrl
//            self.checkIfSelected = checkIfSelected
    
        }
}
