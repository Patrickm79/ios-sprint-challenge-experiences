//
//  Experience+Location.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import Foundation
import CoreLocation

extension ExperienceViewController: CLLocationManagerDelegate {
        
    func setUpLocations() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        
        case .notDetermined:
            
            locationManager.requestAlwaysAuthorization()
            
        case .authorizedWhenInUse:
            
            locationManager.requestLocation()
            
        case .authorizedAlways:
            
            locationManager.requestLocation()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard locations.first?.coordinate != nil else {
            print("No locations found")
            return
        }
        
        updatedCoordinates = locations.last?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Error setting up locations: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
    
        locationManager.requestLocation()
    }
}
