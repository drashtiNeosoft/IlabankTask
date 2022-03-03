//
//  ImageCarouselCollectionViewCell.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import UIKit

class ImageCarouselCollectionViewCell: UICollectionViewCell {

    // MARK: Outlets
    @IBOutlet weak var imageName: UIImageView!
    
    // MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: Update Cell Detail
    func updateCell(albumDetail:AlbumModel?) {
        if let url = URL.init(string: albumDetail?.thumbnailUrl ?? "") {
            self.imageName.loadImageFromUrl(url: url)
        }
    }

}
