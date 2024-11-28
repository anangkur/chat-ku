//
//  ViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 22/11/24.
//

import UIKit
import FirebaseCore
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = Constant.title
    }

}

