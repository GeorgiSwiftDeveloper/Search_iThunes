//
//  FavoriteSongsCollectionViewCell.swift
//  iTunes_Search
//
//  Created by Georgi Malkhasyan on 4/4/20.
//  Copyright © 2020 Malkhasyan. All rights reserved.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreImageView: UIImageView!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    
    
    func confiigurationCell(_ albums: GenreModel) {
            self.genreNameLabel.text = albums.genreTitle
            self.genreImageView.image = UIImage(named: albums.genreImage)
            self.genreImageView.layer.cornerRadius = 4
    }
    

    
}