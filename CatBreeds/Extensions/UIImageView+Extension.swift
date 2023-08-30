//
//  UIImageView+Extension.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(url: String?) {
        guard let urlStr = url, let url = URL(string: urlStr) else {
            return
        }
        self.kf.setImage(with: url)
    }
}
