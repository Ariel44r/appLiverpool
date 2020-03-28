//
//  ResultsTableViewController.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

class ResultsTableViewController: BaseTableViewController {
    
    var viewModel: ViewModel!
    var pageCounter: Int!
    let reuseIdentifier: String = "reuseID"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel.shared
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        pageCounter = 1
        tableView?.keyboardDismissMode = .onDrag
        
    }
    
    func searchFor(text: String) {
        viewModel?.getItems(with: text.uppercased(), pageNumber: pageCounter, itemsPerPage: 20, onSuccess: { apiResponse in
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
                
            }
        }, onError: { error in
            debugPrint(error)
            
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.records?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        weak var cell: ItemTableViewCell! = UIView.fromNib()
        cell.tag = indexPath.row
        viewModel?.set(with: cell)
        return cell
        
    }
    
}

extension ResultsTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        debugPrint("didBeginEditing")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("searchButtonClicked")
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" && searchText != "" {
            searchFor(text: searchText)
        }
    }
}
