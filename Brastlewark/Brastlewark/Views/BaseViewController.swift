//
//  BaseViewController.swift
//  Brastlewark
//
//  Created by Cano Rudkin, Elliot Joseph on 14/6/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction private func backClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
