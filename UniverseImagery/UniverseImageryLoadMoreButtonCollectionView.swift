//
//  UniverseImageryLoadMoreButtonCollectionView.swift
//  UniverseImagery
//
//  Created by Bharath on 16/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import Foundation
import UIKit

enum UniverseImageryLoadMoreViewState {
    case notStarted
    case inProgress
    case finished
}

protocol UniverseImageryLoadMoreButtonCollectionViewDelegate: class {
    func reactToLoadMoreButtonTap()
}

class UniverseImageryLoadMoreButtonCollectionView: UICollectionReusableView {
    
    var currentState: UniverseImageryLoadMoreViewState = .notStarted
    var activityIndicatorView: UIActivityIndicatorView! = nil
    var loadMoreButton: UIButton! = nil
    weak var viewDelegate: UniverseImageryLoadMoreButtonCollectionViewDelegate? = nil
    
    
   
    override init(frame: CGRect) {
        
        currentState = .notStarted
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.lightGray
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        activityIndicatorView =  UIActivityIndicatorView(style: .medium)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        activityIndicatorView.startAnimating()
        
        loadMoreButton = UIButton(type: .system)
        loadMoreButton.addTarget(self, action: #selector(loadMoreButtonTapped(_:)), for: .touchUpInside)
        loadMoreButton.setTitle("Load more", for: .normal)
        loadMoreButton.titleLabel?.textAlignment = .center
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadMoreButton)
        loadMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        loadMoreButton.trailingAnchor.constraint(equalTo: activityIndicatorView.leadingAnchor, constant: -8.0).isActive = true
    }
    
    
    @objc func loadMoreButtonTapped(_ sender: UIButton) {
        viewDelegate?.reactToLoadMoreButtonTap()
    }
    
}
