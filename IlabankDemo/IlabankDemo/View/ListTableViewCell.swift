//
//  ListTableViewCell.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
   
    // MARK: Outlets
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Update List Cell detail
    func updateCell(album: AlbumModel?) {
        self.lblTitle.text = album?.title ?? ""
        if let url = URL.init(string: album?.thumbnailUrl ?? "") {
            self.imgLeft.loadImageFromUrl(url: url)
        }
    }
}
