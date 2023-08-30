//
//  ContentsViewController.swift
//  CatBreeds
//
//  Created by yunus oktay on 16.04.2022.
//

import UIKit
import AVFoundation

class ContentsViewController: BaseViewController {

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Service
    let service = Service()
    
    var contents: [ContentsResponse] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContents()
        configureTableView()
        searchBar.delegate = self
    }
    
    func getContents() {
        service.getContents { contentsResponse in
            self.contents = contentsResponse
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "ContentsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ContentsTableViewCell")
    }
}

extension ContentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsTableViewCell", for: indexPath) as! ContentsTableViewCell
        let contents = contents[indexPath.row]
        cell.configure(with: contents)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "toDetails") as? DetailsViewController else { return  }
        detailsVC.catName = contents[indexPath.row].name
        detailsVC.descriptionText = contents[indexPath.row].description
        detailsVC.lifeSpan = contents[indexPath.row].lifeSpan
        detailsVC.originText = contents[indexPath.row].origin
        detailsVC.dogFriendlyText = contents[indexPath.row].dogFriendly
        detailsVC.temperamentText = contents[indexPath.row].temperament
        if contents[indexPath.row].image?.url != nil {
            detailsVC.image_url = (contents[indexPath.row].image?.url)!
        }
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ContentsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            service.getContents { contentsResponse in
                self.contents = contentsResponse
            }
        } else {
            service.getContentsSearch(searchParameter: searchText) { contentsResponse in
                self.contents = contentsResponse
            }
        }
    }
}
