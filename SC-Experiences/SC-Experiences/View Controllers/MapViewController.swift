//
//  MapViewController.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var experienceController = ExperienceController()
    
       @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addExperienceAnnotations()
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        var center = CLLocationCoordinate2D()
        
        if let UnwrappedCenter = experienceController.experiences.last?.coordinate {
            center = UnwrappedCenter
            
        } else {
            print("No coordinates found for region update")
        }
        
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func addExperienceAnnotations() {
        let experiences = Set(experienceController.experiences)
        
        let currentAnnotations = Set(mapView.annotations.compactMap({ $0 as? Experience }))
        
        let addedExperiences = Array(experiences.subtracting(currentAnnotations))
        
        mapView.addAnnotations(addedExperiences)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecordExperience" {
            
            guard let navController = segue.destination as? UINavigationController,
                let destinationVC = navController.children.first as? ExperienceViewController else { return }
            destinationVC.experienceController = experienceController
        }
    }
}
