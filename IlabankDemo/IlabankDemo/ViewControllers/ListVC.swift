//
//  ListVC.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import UIKit

class ListVC: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var cnstBottom: NSLayoutConstraint!
   
    // MARK: Properties
    let albumViewModel =  AlbumViewModel()
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupListUI()
        self.albumViewModel.getAlbumsDetail { isSuccess in
            self.listTableView.reloadData()
        }
    }
  
    // MARK: Setup UI
    fileprivate func setupListUI() {
        self.listTableView.register(UINib(nibName: "ImageCarouselTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarouselTableViewCell")
        self.listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        print("selected Item: \(self.albumViewModel.getSelectedBanner(index: self.albumViewModel.selectedBannerIndex)?.albumId ?? 0)")
        if #available(iOS 15.0, *) {
            listTableView.sectionHeaderTopPadding = 0
        }
    }
}
// MARK: - TableView Datasource
extension ListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return self.albumViewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, indexPath.row == 0 {
            let imageCarouselTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ImageCarouselTableViewCell") as? ImageCarouselTableViewCell
            imageCarouselTableViewCell?.loadaData(totalPages: self.albumViewModel.getcarouselListCount(), currentPage: self.albumViewModel.selectedBannerIndex, item: self.albumViewModel.getSelectedBanner(index: self.albumViewModel.selectedBannerIndex))
            imageCarouselTableViewCell?.blockCallForReloadSection = { index in
                self.albumViewModel.setSelectedBannerIndex(index: index)
                self.albumViewModel.albumList?.shuffle()
                self.listTableView.reloadData()
            }
            return imageCarouselTableViewCell ?? UITableViewCell()
        } else {
            let listTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell
            listTableViewCell?.updateCell(album: self.albumViewModel.getSelectedAlbum(index: indexPath.row))
            return listTableViewCell ?? UITableViewCell()
        }
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 43))
        let searchBar = createSearchBar(frame: headerView.frame)
        headerView.addSubview(searchBar)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 43
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0, indexPath.section == 0 {
            return (view.frame.height * 30) / 100
        } else {
            return UITableView.automaticDimension
        }
    }
    
    /// Setup search bar
    private func createSearchBar(frame: CGRect) -> UISearchBar {
        let searchBar = CustomSearchBar.init(frame: frame)
        searchBar.searchTextField.text = albumViewModel.serachText
        searchBar.delegate = self
        return searchBar
    }
   
}
//MARK: - Searchbar delegates
extension ListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        albumViewModel.serachText = searchText
        albumViewModel.searchList(searchText: searchText)
        self.listTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
