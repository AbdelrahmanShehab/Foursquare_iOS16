//
//  PlacesViewController.swift
//  Foursquare
//
//  Created by Abdelrahman Shehab on 13/05/2023.
//

import UIKit
import Parse

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedPlaceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClciked))
        
        getDataFromParse()
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Posts")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                Alert.makeAlert(on: self, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil {
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeID = object.objectId {
                                self.placeIdArray.append(placeID)
                                self.placeNameArray.append(placeName)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func addButtonClicked() {
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
    
    @objc func logoutButtonClciked() {
        
        PFUser.logOutInBackground { error in
            if error != nil {
                Alert.makeAlert(on: self, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let detinationVC = segue.destination as! DetailsViewController
            detinationVC.chosenPlaceID = selectedPlaceID
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceID = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
}
