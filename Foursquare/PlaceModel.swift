//
//  PlaceModel.swift
//  Foursquare
//
//  Created by Abdelrahman Shehab on 14/05/2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude =  ""
    
    private init() {}
}