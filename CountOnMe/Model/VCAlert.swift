//
//  VCAlert.swift
//  P5_01_Xcode
//
//  Created by Paul Ghibeaux on 05/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

protocol VCAlertDelegate: ViewController {
    func presentVCAlert(with: String)
}


extension VCAlertDelegate {
    func presentVCAlert(with message: String) {
        let alertVC = UIAlertController(title: "Erreur !", message: message, preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alertVC, animated: true, completion: nil)
    }
}
