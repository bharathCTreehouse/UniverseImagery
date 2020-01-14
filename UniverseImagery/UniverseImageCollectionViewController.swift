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
    
    var imageViewModels: [UniverseImageViewModel] {
        didSet {
            
            if imageViewModels.isEmpty == false {
                downloadImages()
            }
        }
    }
    
    lazy private var imageDownloadingQueue: OperationQueue = {
       return OperationQueue()
    }()
    
    
    required init(withImageViewModels viewModels: [UniverseImageViewModel]) {
        imageViewModels = viewModels
        super.init(nibName: "UniverseImageCollectionViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.title = "IMAGES"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterOutViewModelsWithoutImages()
    }
    
    
    func filterOutViewModelsWithoutImages() {
        
        imageViewModels = imageViewModels.filter({ (vm: UniverseImageViewModel) -> Bool in
            return vm.image == nil
        })
    }
    
    
    func downloadImages() {
        
        for (index, imageViewModel) in imageViewModels.enumerated() {
            
            let url: URL = URL(string: imageViewModel.imageData.url)!
            
            let imgOperation: UniverseImageOperation = UniverseImageOperation(withImageUrl: url, uniqueIdentifier: "\(index)", completionHandler: { [unowned self] (img: UIImage?, identifier: String?, err: Error?, cancelled: Bool) -> Void in
                
                if let img = img {
                    
                    let index: Int? = Int(identifier ?? "")
                    
                    if let index = index {
                        
                        let viewModel = self.imageViewModels[index]
                        viewModel.updateImage(with: img)
                        
                        DispatchQueue.main.async {
                            
                            let cell = self.collectionView.cellForItem(at: IndexPath.init(row: index, section: 0))
                            (cell?.contentView.viewWithTag(10) as? UIImageView)?.image = img
                        }
                    }
                }
            })
            imageDownloadingQueue.addOperation(imgOperation)
        }
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
}


extension UniverseImageCollectionViewController {
    
    // MARK: UICollectionViewDelegate
    
    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    /*override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }*/
    

    
    // Uncomment this method to specify if the specified item should be selected
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
