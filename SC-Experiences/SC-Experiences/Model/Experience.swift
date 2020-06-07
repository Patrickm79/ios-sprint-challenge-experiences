//
//  Experience.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import Foundation
import MapKit

class Experience: NSObject, MKAnnotation {
    
    init(title: String, image: UIImage, coordinate: CLLocationCoordinate2D, id: String) {
        self.title = title
        self.image = image
        self.coordinate = coordinate
        self.id = id
    }
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage
    var id: String
    var audioURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let file = documents.appendingPathComponent("\(id)audio", isDirectory: false).appendingPathExtension("caf")
        
        print("recording URL: \(file)")
        
        return file
    }
    
    var videoURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let file = documents.appendingPathComponent("\(id)video", isDirectory: false).appendingPathExtension("mov")
        
        print("recording URL: \(file)")
        
        return file
    }
}
