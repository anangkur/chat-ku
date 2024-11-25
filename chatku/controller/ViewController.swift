//
//  ViewController.swift
//  chatku
//
//  Created by Anang Kurniawan on 22/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Chat Ku"
    }


}

