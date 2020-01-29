//
//  UniverseImageCollectionViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 14/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class UniverseImageCollectionViewController: UICollectionViewController {
    
    private(set) var imageViewModels: [UniverseImageViewModel] {
        
        willSet(oldValue) {
            
        }
        
        didSet {
            
            let noOfNewItemsAdded: Int = imageViewModels.count - oldValue.count
            var newIndexPaths: [IndexPath] = []
            
            if noOfNewItemsAdded > 0 {
                //There has been an addition of new image view models.
                
                for (index, _) in imageViewModels.enumerated() {
                    
                    if index >= oldValue.count {
                        //'index' is now an index that is newly appended. So add it into a list of indexPaths that can be used to insert new collection items.
                        let idxPath: IndexPath = IndexPath.init(row: index, section: 0)
                        newIndexPaths.append(idxPath)
                        if newIndexPaths.count == noOfNewItemsAdded {
                            break
                        }
                    }
                }
                
            }
            if imageViewModels.isEmpty == false {
                collectionView.insertItems(at: newIndexPaths)
                if imageDownloadingQueue == nil {
                    imageDownloadingQueue = OperationQueue()
                }
                downloadImages()
            }
        }
    }
    
    private(set) var imageDownloadingQueue: OperationQueue? = nil
    
    let loadMoreHandler: (() -> Void)
    
    var loadMoreState: UniverseImageryLoadMoreViewState = .notStarted {
        
        didSet {
            updateLoadMoreViewState()
        }
    }
    
    
    required init(withImageViewModels viewModels: [UniverseImageViewModel], loadMoreTapHandler: @escaping () -> Void ) {
        
        imageViewModels = viewModels
        loadMoreHandler = loadMoreTapHandler
        super.init(nibName: "UniverseImageCollectionViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addImageViewModels(fromList list: [UniverseImageViewModel]) {
        
        loadMoreState = .finished
        if list.isEmpty == false {
            let filteredList: [UniverseImageViewModel] = list.imageViewModelsWithoutImage()
            imageViewModels.append(contentsOf: filteredList)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if imageViewModels.isEmpty == false {
            
            //Only when there are images in the collection view controller, configure and setup the 'load more' button footer view.
            
            collectionView!.register(UniverseImageryLoadMoreButtonCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadMoreView")
            
            (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).footerReferenceSize = CGSize(width: collectionView.frame.size.width, height: 60.0)
        }
        
        navigationItem.title = "IMAGES"
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        //Filter out image view models whose images haven't yet been fetched.
        imageViewModels = imageViewModels.imageViewModelsWithoutImage()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        //Cancell all pending image operations since we are exiting the screen.
        imageDownloadingQueue?.cancelAllOperations()
        imageDownloadingQueue = nil
    }
    
    
    func downloadImages() {
        
        for (index, imageViewModel) in imageViewModels.enumerated() {
            
            if imageViewModel.image != nil {
                //Image already downloaded for this view model. So continue the loop.
                continue
            }
            
            let url: URL = URL(string: imageViewModel.imageData.url)!
            
            let imgOperation: UniverseImageOperation = UniverseImageOperation(withImageUrl: url, uniqueIdentifier: "\(index)", completionHandler: { [unowned self] (img: UIImage?, identifier: String?, err: Error?, cancelled: Bool) -> Void in
                
                if cancelled == true {
                    //Do nothing since the operation has been cancelled.
                    return
                }
                if let img = img {
                    
                    let index: Int? = Int(identifier ?? "")
                    
                    if let index = index {
                        
                        //Update the view model with downloaded image.
                        let viewModel = self.imageViewModels[index]
                        viewModel.updateImage(with: img)
                        
                        //UI update
                        DispatchQueue.main.async {
                            
                            let idxPath: IndexPath = IndexPath.init(row: index, section: 0)
                            let cell = self.collectionView.cellForItem(at: idxPath)
                            (cell?.contentView.viewWithTag(10) as? UIImageView)?.image = img
                            
                        }
                    }
                }
            })
            imageDownloadingQueue?.addOperation(imgOperation)
        }
    }
    
    
    deinit {
        imageDownloadingQueue = nil
    }
}



extension UniverseImageCollectionViewController {
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        var imgView: UIImageView? = cell.contentView.viewWithTag(10) as? UIImageView
        
        if imgView == nil {
            
            //Add the image view.
            imgView = UIImageView()
            imgView!.translatesAutoresizingMaskIntoConstraints = false
            imgView!.tag = 10
            cell.contentView.addSubview(imgView!)
            imgView!.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            imgView!.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
            imgView!.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            imgView!.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            imgView!.image = nil
        }
        let imageViewModel: UniverseImageViewModel = imageViewModels[indexPath.row]
        imgView!.image = imageViewModel.image
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let loadMoreView: UniverseImageryLoadMoreButtonCollectionView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadMoreView", for: indexPath) as! UniverseImageryLoadMoreButtonCollectionView
        loadMoreView.changeCurrentState(to: loadMoreState)
        loadMoreView.viewDelegate = self
        
        return loadMoreView
    }

}


extension UniverseImageCollectionViewController {
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageTapped: UIImage? = imageViewModels[indexPath.row].image
        
        if let imageTapped = imageTapped {
            
            let imageVC: UniverseImageViewController = UniverseImageViewController(withUniverseImage: imageTapped)
            let navController: UINavigationController = UINavigationController(rootViewController: imageVC)
            present(navController, animated: true, completion: nil)
        }
    }
}


extension UniverseImageCollectionViewController: UniverseImageryLoadMoreButtonCollectionViewDelegate {
    
    
    func reactToLoadMoreButtonTap() {
        loadMoreState = .inProgress
        loadMoreHandler()
    }
    
    
    func updateLoadMoreViewState() {
        
        let indexPath: IndexPath = IndexPath.init(row: 0, section: 0)
        
        let loadMoreFooterView: UniverseImageryLoadMoreButtonCollectionView? = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: indexPath) as? UniverseImageryLoadMoreButtonCollectionView
        
        loadMoreFooterView?.changeCurrentState(to: loadMoreState)
    }
}
