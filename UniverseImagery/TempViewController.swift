//
//  TempViewController.swift
//  UniverseImagery
//
//  Created by Bharath on 15/01/20.
//  Copyright © 2020 Bharath. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let imageInQuestion: UIImage
    
    init(withImg img: UIImage) {
        imageInQuestion = img
        super.init(nibName: "TempViewController", bundle: .main)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = imageInQuestion
        navigationItem.title = "POST CARD IMAGE"

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
