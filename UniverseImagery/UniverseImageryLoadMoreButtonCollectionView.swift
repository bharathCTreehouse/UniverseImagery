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
    
    private var currentState: UniverseImageryLoadMoreViewState = .notStarted {
        
        didSet {
            if currentState == .inProgress {
                activityIndicatorView.startAnimating()
                loadMoreButton.isEnabled = false
            }
            else {
                activityIndicatorView.stopAnimating()
                loadMoreButton.isEnabled = true
            }
        }
    }
    
    var activityIndicatorView: UIActivityIndicatorView! = nil
    var loadMoreButton: UIButton! = nil
    weak var viewDelegate: UniverseImageryLoadMoreButtonCollectionViewDelegate? = nil
    
    
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.lightText
        setup()
        changeCurrentState(to: .notStarted)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        
        activityIndicatorView =  UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        
        loadMoreButton = UIButton(type: .system)
        loadMoreButton.addTarget(self, action: #selector(loadMoreButtonTapped(_:)), for: .touchUpInside)
        loadMoreButton.setTitle("LOAD MORE", for: .normal)
        loadMoreButton.titleLabel?.textAlignment = .center
        loadMoreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        loadMoreButton.setTitleColor(UIColor.systemBlue, for: .normal)
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadMoreButton)
        loadMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        loadMoreButton.trailingAnchor.constraint(equalTo: activityIndicatorView.leadingAnchor, constant: -8.0).isActive = true
    }
    
    
    @objc func loadMoreButtonTapped(_ sender: UIButton) {
        viewDelegate?.reactToLoadMoreButtonTap()
    }
    
    
    func changeCurrentState(to newState: UniverseImageryLoadMoreViewState) {
        currentState = newState
    }
}
