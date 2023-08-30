//
//  DetailsViewController.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var dogFriendlyLabel: UILabel!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var temperamentLabel: UILabel!
    
    var image_url: String = ""
    var catName: String = ""
    var lifeSpan: String = ""
    var descriptionText: String = ""
    var originText: String = ""
    var dogFriendlyText: Int = 0
    var buttonTag: Int = 0
    var temperamentText: String = ""
    var catImageData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "catLogom")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor.self = .black
        configure()
    }
    
    func configure() {
        lifeSpanLabel?.text = lifeSpan
        descriptionTextView?.text = descriptionText
        originLabel?.text = originText
        dogFriendlyLabel?.text = dogFriendlyText.toString()
        catNameLabel?.text = catName
        temperamentLabel.text = temperamentText
        imageView.image = UIImage(data: catImageData)
        guard (imageView?.setImage(url: image_url)) != nil else {
            return print("error")
        }
    }

    @IBAction func favBtnTapped(_ sender: Any) {
        
        if favBtn.tag == 0 {
            favBtn.setImage(UIImage(named: "favorite1"), for: .normal)
            favBtn.tag = 1
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let saveData = NSEntityDescription.insertNewObject(forEntityName: "CatProperty", into: context)
            
            saveData.setValue(catNameLabel.text!, forKey: "catName")
            
            let imagePress = imageView.image?.jpegData(compressionQuality: 0.5)
            saveData.setValue(imagePress, forKey: "catImage")
            
            saveData.setValue(UUID(), forKey: "id")
            
            saveData.setValue(descriptionText, forKey: "descriptionText")
            
            saveData.setValue(originText, forKey: "origin")
            
            saveData.setValue(dogFriendlyText, forKey: "dogFriendly")
            
            saveData.setValue(image_url, forKey: "imageUrl")
            
            saveData.setValue(lifeSpan, forKey: "lifeSpan")
            
            saveData.setValue(temperamentText, forKey: "temperament")
            
            
            do {
                try context.save()
                print("Success")
            } catch {
                print("error")
            }
            
        } else {
            favBtn.setImage(UIImage(named: "favorite0"), for: .normal)
            favBtn.tag = 0
        }
    }
}


