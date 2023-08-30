//
//  BaseViewController.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "catLogom")
        let imageView = UIImageView(image: logo)
        
        self.navigationItem.titleView = imageView
        
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem = backBtn
        navigationItem.backBarButtonItem?.tintColor = .black

        let favBtn = UIBarButtonItem(image: UIImage(named: "fav"), style: .plain, target: self, action: #selector(openFavVC))
        navigationItem.rightBarButtonItem = favBtn
        favBtn.tintColor = .red
        
    }
    
    
    @objc func openFavVC() {
        let cartVC = FavoriteViewController()
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
}
