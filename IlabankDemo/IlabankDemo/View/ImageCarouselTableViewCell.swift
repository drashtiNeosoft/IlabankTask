//
//  ImageCarouselTableViewCell.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import UIKit

class ImageCarouselTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
   
    // MARK: Properties
    var blockCallForReloadSection:((_ index: Int)-> Void)?
    var albumDetail: AlbumModel?
    
    // MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: Setup UI
    private func setupUI() {
        self.carouselCollectionView.register(UINib(nibName: "ImageCarouselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCarouselCollectionViewCell")
        self.carouselCollectionView.dataSource = self
        self.carouselCollectionView.delegate = self
        self.carouselCollectionView.contentInsetAdjustmentBehavior = .never
    }
    // MARK: Load data
    func loadaData(totalPages: Int, currentPage: Int, item: AlbumModel?) {
        self.albumDetail = item
        self.pageControl.currentPage = currentPage
        self.pageControl.numberOfPages = totalPages
    }
    
}
// MARK: Collectionview Datasource and delegate
extension ImageCarouselTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pageControl.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coursouelCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCarouselCollectionViewCell", for: indexPath) as? ImageCarouselCollectionViewCell
        coursouelCollectionCell?.updateCell(albumDetail: self.albumDetail)
        return coursouelCollectionCell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.carouselCollectionView.frame.width, height: self.carouselCollectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if !scrollView.isPagingEnabled { return }
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl?.currentPage = index
        if let reloadListSection = self.blockCallForReloadSection {
            reloadListSection(index)
        }
    }
    
}
