//
//  extenstion+customfunction.swift
//  IlabankDemo
//
//  Created by Drashti Javiya on 02/03/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageFromUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage.init(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
