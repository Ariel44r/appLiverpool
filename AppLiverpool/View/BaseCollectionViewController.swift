//
//  BaseCollectionViewController.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionCell"

class BaseCollectionViewController: UICollectionViewController {

    var searchController: UISearchController!
    var resultsController: ResultsTableViewController!
    var viewModel: ViewModel!
    var pageCounter: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        title = "Liverpool"
        ViewModel.reset()
        viewModel = ViewModel.shared
        pageCounter = 0
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.masterColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.masterColor]
        setSearchController()
        searchFor(text: "xbox")
        
    }
    
    func searchFor(text: String) {
        viewModel?.getItems(with: text.uppercased(), pageNumber: pageCounter, itemsPerPage: 20, onSuccess: { apiResponse in
            debugPrint(apiResponse)
        }, onError: { error in
            debugPrint(error)
            
        })
    }
    
    func setSearchController() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        navigationController?.navigationBar.isTranslucent = true
        resultsController = ResultsTableViewController(nibName: "ResultsTableViewController", bundle: nil)
        searchController = UISearchController(searchResultsController: resultsController)
        navigationItem.searchController = searchController
        searchController?.searchBar.tintColor = .masterColor
        searchController?.searchBar.delegate = self
        
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension BaseCollectionViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        debugPrint("didBeginEditing")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("searchButtonClicked")
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint("textDidChange: \(searchText)")
        
    }
}
