//
//  ContentsTableViewCell.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import UIKit
import CoreData



class ContentsTableViewCell: UITableViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.23
            layer.shadowRadius = 4
        contentView.layer.shadowOffset = CGSize(width: 0.05, height: 0.05)
        layer.shadowColor = UIColor.black.cgColor
        contentView.backgroundColor = UIColor(named: "Color3")
            contentView.layer.cornerRadius = 20
        
    }
    
    var lifeSpan = ""
    var descriptionText = ""
    var origin = ""
    var dogFriendly = 0
    var imageUrl = ""
    var temperament = ""
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with contents: ContentsResponse) {
        nameLabel.text = contents.name
        catImageView.setImage(url: contents.image?.url)
        lifeSpan = contents.lifeSpan
        descriptionText = contents.description
        origin = contents.origin
        dogFriendly = contents.dogFriendly
        temperament = contents.temperament
        
    }
    
    @IBAction func favoriteAddButton(_ sender: UIButton) {
        
        if favoriteButton.tag == 0 {
            favoriteButton.setImage(UIImage(named: "favorite1"), for: .normal)
            favoriteButton.tag = 1
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let saveData = NSEntityDescription.insertNewObject(forEntityName: "CatProperty", into: context)
            
            saveData.setValue(nameLabel.text!, forKey: "catName")
            
            let imagePress = catImageView.image?.jpegData(compressionQuality: 0.5)
            saveData.setValue(imagePress, forKey: "catImage")
            
            saveData.setValue(UUID(), forKey: "id")
            
            saveData.setValue(lifeSpan, forKey: "lifeSpan")
            
            saveData.setValue(descriptionText, forKey: "descriptionText")
            
            saveData.setValue(origin, forKey: "origin")
            
            saveData.setValue(dogFriendly, forKey: "dogFriendly")
            
            saveData.setValue(imageUrl, forKey: "imageUrl")
            
            saveData.setValue(temperament, forKey: "temperament")
            
            
            
            do {
                try context.save()
                print("Success")
            } catch {
                print("error")
            }
            
        } else {
            
            favoriteButton.setImage(UIImage(named: "favorite0"), for: .normal)
            favoriteButton.tag = 0
            
            
        }
        
        
    }
}
