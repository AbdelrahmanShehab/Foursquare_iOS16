//
//  Alert.swift
//  Foursquare
//
//  Created by Abdelrahman Shehab on 14/05/2023.
//

import Foundation
import UIKit

struct Alert {
    
    static func makeAlert(on VC: UIViewController, titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        VC.present(alert, animated: true)
    }
}
