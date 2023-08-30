////
////  ContentsViewModel.swift
////  CatBreeds
////
////  Created by yunus oktay on 28.08.2023.
////
//
//import Foundation
//
//protocol ContentsViewModelInterface {
//    var view: ContentsViewInterface? { get set }
//    func viewDidLoad()
//}
//
//final class ContentsViewModel {
//    weak var view: ContentsViewInterface?
//
//    let service = Service()
//    var contents: [ContentsResponse] = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
////            }
//        }
//    }
//
//    private func getContents() {
//        service.getContents { contentsResponse in
//            self.contents = contentsResponse
//        }
//    }
//}
//
//extension ContentsViewModel: ContentsViewModelInterface {
//    func viewDidLoad() {
//        view?.prepareTableView()
//        getContents()
//
//    }
//
//
//}
