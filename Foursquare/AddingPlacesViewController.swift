//
//  AddingPlacesViewController.swift
//  Foursquare
//
//  Created by Abdelrahman Shehab on 13/05/2023.
//

import UIKit

class AddingPlacesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var placeTypeTextField: UITextField!
    @IBOutlet weak var placeAtmosphereTextField: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if placeNameTextField.text != "" && placeTypeTextField.text != "" && placeAtmosphereTextField.text != "" {
            if let chosenImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameTextField.text!
                placeModel.placeType = placeTypeTextField.text!
                placeModel.placeAtmosphere = placeAtmosphereTextField.text!
                placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: self)
        } else {
            Alert.makeAlert(on: self, titleInput: "Error", messageInput: "Place (Name/Type/Atmosphere) !!")
        }
    }
    

    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
