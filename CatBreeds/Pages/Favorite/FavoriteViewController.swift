//
//  FavoriteViewController.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import UIKit
import CoreData


class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var catNameArr = [String]()
    var idArr = [UUID]()
    var catImageArr = [Data]()
    var lifeSpanArr = [String]()
    var descriptionArr = [String]()
    var originArr = [String]()
    var dogFriendlyArr = [Int]()
    var imageUrlArr = [String]()
    var temperamentArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "catLogom")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        configureTableView()
        getData()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ContentsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContentsTableViewCell")
    }
    
    func getData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatProperty")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                
                if let catName = result.value(forKey: "catName") as? String {
                    self.catNameArr.append(catName)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArr.append(id)
                }
                
                if let catImage = result.value(forKey: "catImage") as? Data {
                    self.catImageArr.append(catImage)
                }
                
                if let lifeSpan = result.value(forKey: "lifeSpan") as? String {
                    self.lifeSpanArr.append(lifeSpan)
                }
                
                if let description = result.value(forKey: "descriptionText") as? String {
                    self.descriptionArr.append(description)
                }
                
                if let origin = result.value(forKey: "origin") as? String {
                    self.originArr.append(origin)
                }
                
                if let dogFriendly = result.value(forKey: "dogFriendly") as? Int {
                    self.dogFriendlyArr.append(dogFriendly)
                }
                
                if let temperament = result.value(forKey: "temperament") as? String {
                    self.temperamentArr.append(temperament)
                }
                    
                self.tableView.reloadData()
            }
            
        } catch {
            
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsTableViewCell", for: indexPath) as! ContentsTableViewCell
        cell.nameLabel.text = catNameArr[indexPath.row]
        cell.catImageView.image = UIImage(data: catImageArr[indexPath.row])
        cell.temperament = temperamentArr[indexPath.row]
        cell.lifeSpan = lifeSpanArr[indexPath.row]
        cell.dogFriendly = dogFriendlyArr[indexPath.row]
        cell.descriptionText = descriptionArr[indexPath.row]
        cell.origin = originArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC =  storyBoard.instantiateViewController(withIdentifier: "toDetails") as! DetailsViewController
        detailsVC.catName = catNameArr[indexPath.row]
        detailsVC.lifeSpan = lifeSpanArr[indexPath.row]
        detailsVC.descriptionText = descriptionArr[indexPath.row]
        detailsVC.originText = originArr[indexPath.row]
        detailsVC.dogFriendlyText = dogFriendlyArr[indexPath.row]
        detailsVC.catImageData = catImageArr[indexPath.row]
        detailsVC.temperamentText = temperamentArr[indexPath.row]
       
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatProperty")
        
        let idString = idArr[indexPath.row].uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let _ = result.value(forKey: "id") as? UUID {
                    context.delete(result)
                    catNameArr.remove(at: indexPath.row)
                    idArr.remove(at: indexPath.row)
                    catImageArr.remove(at: indexPath.row)
                    descriptionArr.remove(at: indexPath.row)
                    lifeSpanArr.remove(at: indexPath.row)
                    originArr.remove(at: indexPath.row)
                    dogFriendlyArr.remove(at: indexPath.row)
                    temperamentArr.remove(at: indexPath.row)
                    self.tableView.reloadData()
                    
                    do {
                        try context.save()
                    } catch {
                        
                    }
                }
            }
        } catch {
            
        }
        
    }
}
