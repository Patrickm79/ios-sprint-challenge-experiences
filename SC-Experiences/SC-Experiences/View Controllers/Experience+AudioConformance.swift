//
//  Experience+AudioConformance.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/6/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension ExperienceViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var isPlaying: Bool { return player?.isPlaying ?? false }
    var isRecording: Bool { return recorder?.isRecording ?? false }
    
    func recordAudio() {
        updateViewButtons()
        
        guard !isRecording else {
            recorder?.stop()
            return
        }
        
        do {
            let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)!
            recorder = try AVAudioRecorder(url: newRecordingURL(), format: format)
            recorder?.prepareToRecord()
            recorder?.delegate = self
            recorder?.record()
        } catch {
            let alertController = UIAlertController(title: "Error recording audio", message: "Please try again!", preferredStyle: .alert)
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAlert)
            self.present(alertController, animated: true, completion: nil)
        }
        print("Starting recording")
    }
    
    func playAudio() {
        updateViewButtons()
        guard let url = ExperienceViewController.recordingURL else {
            return
        }
        
        guard !isPlaying else {
            player?.stop()
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
        } catch {
            let alertController = UIAlertController(title: "Error playing audio", message: "Please try again!", preferredStyle: .alert)
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAlert)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        ExperienceViewController.recordingURL = recorder.url
        updateViewButtons()
        self.recorder = nil
        print("Finished recording")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateViewButtons()
        self.player = nil
    }
    
    private func newRecordingURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documents.appendingPathComponent(id).appendingPathExtension("caf")
    }
    
    func updateViewButtons() {
                
        let playButtonTitle = isPlaying ? "Stop Playing" : "Play"
        let recordButtonTitle = isRecording ? "Stop Recording" : "Record"
        
        playRecordingButton.setTitle(playButtonTitle, for: .normal)
        recordAudioButton.setTitle(recordButtonTitle, for: .normal)
    }
}
