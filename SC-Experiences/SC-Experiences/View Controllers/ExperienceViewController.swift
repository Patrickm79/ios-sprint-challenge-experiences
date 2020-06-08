//
//  ExperienceViewController.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit
import CoreImage
import AVFoundation
import CoreLocation

class ExperienceViewController: UIViewController, UITextFieldDelegate {
    
    var experienceController = ExperienceController()
    let locationManager = CLLocationManager()
    let context = CIContext(options: nil)
    var id: String!
    var recordCount = 0
    var audioHasBeenRecorded = false
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var recordingURL: URL?
    var experience: Experience?
    var originalImage: UIImage?
    var updatedCoordinates: CLLocationCoordinate2D?
    
    @IBOutlet weak var recordVideoButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var posterImageButton: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var recordAudioButton: UIButton!
    @IBOutlet weak var playRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordVideoButton.isEnabled = false
        setUpLocations()
        locationManager.startUpdatingLocation()
        updateViewButtons()
        titleTextField.delegate = self
        id = UUID().uuidString
    }
    
    @IBAction func addPosterImage(_ sender: Any) {
        presentImagePickerController()
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        recordAudio()
    }
    
    @IBAction func playAudioRecording(_ sender: Any) {
        playAudio()
    }
    
    @IBAction func saveExperience(_ sender: UIBarButtonItem!) {
        
        if let title = titleTextField.text,
            let image = originalImage,
            let coordinates = updatedCoordinates
            //TODO: Maybe see if this needs to be set in the location manager
            {
            let newExperience = experienceController.createExperienceWith(title: title, image: image, coordinate: coordinates, id: id)
            experienceController.saveExperience(newExperience)
            locationManager.stopUpdatingLocation()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecordVideo" {
            //TODO: Inject to the recording VC
        }
    }
}
