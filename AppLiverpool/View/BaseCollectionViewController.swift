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
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let numberOfItems: Int = 5
    var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        setCollectionViewLayout()
        title = "Liverpool"
        ViewModel.reset()
        viewModel = ViewModel.shared
        pageCounter = 1
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.masterColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.masterColor]
        setSearchController()
        if let lastDataQuery = viewModel?.lastDataQueryComputed {
            self.viewModel?.lastDataQuery = lastDataQuery
            collectionView?.reloadData()
        } else {
            searchFor(text: "xbox")
            
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
            self?.setCollectionViewLayout()
            
        })
    }
    
    func setCollectionViewLayout() {
        let size = view.frame.size
        let isLandscapeOrientation: Bool = size.width > size.height
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                let collectionViewFrame = self.collectionView?.frame ?? .zero
                
                let itemsPerWidth: CGFloat = isLandscapeOrientation ? 3.0 : 2.0
                let paddingSpaceWidth = self.sectionInsets.left * (itemsPerWidth + 1.0)
                let availableWidth = collectionViewFrame.width - paddingSpaceWidth
                let widthPerItem = availableWidth / itemsPerWidth

                let itemsPerHeight: CGFloat = isLandscapeOrientation ? 2.0 : 3.0
                let paddingSpaceHeight = self.sectionInsets.bottom * (itemsPerHeight + 1.0)
                let availableHeight = collectionViewFrame.height - paddingSpaceHeight
                let heightPerItem = availableHeight / itemsPerHeight
                
                self.layout = UICollectionViewFlowLayout()
                self.layout?.itemSize = CGSize(width: widthPerItem, height: heightPerItem)
                self.layout?.minimumInteritemSpacing = 5
                self.layout?.minimumLineSpacing = 5
                self.layout?.headerReferenceSize = .zero
                self.layout?.sectionInset = self.sectionInsets
                
                self.collectionView?.collectionViewLayout = self.layout
                
            })
        }
    
    func searchFor(text: String) {
        viewModel?.getItems(with: text.uppercased(), pageNumber: pageCounter, itemsPerPage: 20, onSuccess: { apiResponse in
            DispatchQueue.main.async { [weak self] in
                self?.viewModel?.lastDataQuery = apiResponse
                self?.collectionView?.reloadData()
            }
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
        searchController?.searchBar.delegate = resultsController
        searchController.delegate = self
        
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.lastDataQuery?.plpResults?.records?.count ?? 0
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.tag = indexPath.item
        viewModel?.set(with: cell)
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
        
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

extension BaseCollectionViewController: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        debugPrint("presentSearchController")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        debugPrint("willDismissSearchController")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        debugPrint("willPresentSearchController")
    }
}
