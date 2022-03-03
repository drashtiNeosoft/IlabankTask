//
//  CustomSearchBar.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import UIKit

class CustomSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBarStyle = .prominent
        barStyle = .black
        searchTextField.textColor = .blue
        returnKeyType = .done
        placeholder = " Search"
        sizeToFit()
        isTranslucent = false
        barTintColor = .systemGray5
        
        let searchBarWidth = frame.width
        let placeholderIconWidth = searchTextField.leftView?.frame.width
        let placeHolderWidth = searchTextField.attributedPlaceholder?.size().width
        let offsetIconToPlaceholder: CGFloat = 8
        let placeHolderWithIcon = placeholderIconWidth! + offsetIconToPlaceholder
        let offset = UIOffset(horizontal: ((searchBarWidth / 2) - (placeHolderWidth! / 2) - placeHolderWithIcon), vertical: 0)
        setPositionAdjustment(offset, for: .search)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
