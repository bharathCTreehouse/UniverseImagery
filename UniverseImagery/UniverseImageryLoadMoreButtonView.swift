//
//  UniverseImageryLoadMoreButtonView.swift
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

class UniverseImageryLoadMoreButtonView: UIView {
    
    var currentState: UniverseImageryLoadMoreViewState = .notStarted
    var activityIndicatorView: UIActivityIndicatorView! = nil
    var loadMoreButton: UIButton! = nil
    
    
    init(withCurrentState state: UniverseImageryLoadMoreViewState = .notStarted) {
        currentState = state
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        activityIndicatorView =  UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        
        loadMoreButton = UIButton(type: .system)
        loadMoreButton.setTitle("Load more", for: .normal)
        loadMoreButton.titleLabel?.textAlignment = .center
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadMoreButton)
        loadMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadMoreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        loadMoreButton.trailingAnchor.constraint(equalTo: activityIndicatorView.leadingAnchor, constant: -8.0).isActive = true
    }
    
}
