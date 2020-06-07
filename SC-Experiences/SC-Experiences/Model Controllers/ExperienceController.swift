//
//  ExperienceController.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit
import CoreLocation

class ExperienceController {
    
    func createExperienceWith(title: String, image: UIImage, coordinate: CLLocationCoordinate2D, id: String) -> Experience {
        return Experience(title: title, image: image, coordinate: coordinate, id: id)
    }
    
    func saveExperience(_ experience: Experience) {
        self.experiences.append(experience)
    }
    
    private(set) var experiences: [Experience] = []
}
