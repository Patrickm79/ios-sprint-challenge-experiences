//
//  MapViewController.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var experienceController = ExperienceController()
    
       @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "ExperienceView")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateExperiences()
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        var center = CLLocationCoordinate2D()
        
        if let unwrappedCenter = experienceController.experiences.last?.coordinate {
            center = unwrappedCenter
            
        } else {
            print("No coordinates found for region update")
        }
        
        let region = MKCoordinateRegion(center: center, span: coordinateSpan)
        self.mapView.setRegion(region, animated: true)
    }
    
    func updateExperiences() {
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


// Setting up the popover detail view
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    guard let experience = annotation as? Experience else {
        fatalError("Only experience objects are supported right now")
    }
    
    guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "ExperienceView", for: experience) as? MKMarkerAnnotationView else {
        fatalError("Missing a registered map annotation view")
    }
        annotationView.markerTintColor = .systemBlue
    
    annotationView.canShowCallout = true
    let detailView = ExperienceDetailView()
    detailView.experience = experience
    annotationView.detailCalloutAccessoryView = detailView
    
    return annotationView
    
    }
}
