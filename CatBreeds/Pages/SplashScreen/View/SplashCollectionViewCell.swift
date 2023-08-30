//
//  SplashCollectionViewCell.swift
//  CatBreeds
//
//  Created by yunus oktay on 24.04.2022.
//

import UIKit

class SplashCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing:
                                    SplashCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: SplashSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
