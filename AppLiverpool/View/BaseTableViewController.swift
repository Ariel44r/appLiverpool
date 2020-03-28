//
//  BaseTableViewController.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var searchController: UISearchController!
//    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Liverpool"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.masterColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.masterColor]
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func setSearchController() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        navigationController?.navigationBar.isTranslucent = true
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController?.searchBar.tintColor = .masterColor
    }

}
