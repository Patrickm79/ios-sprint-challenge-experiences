//
//  ExperienceDetailView.swift
//  SC-Experiences
//
//  Created by Patrick Millet on 6/8/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit
import AVFoundation


class ExperienceDetailView: UIView {
    
    var experience: Experience? {
        didSet {
            updateSubViews()
        }
    }
    
    var player: AVAudioPlayer?
    
    var isPlaying: Bool { return player?.isPlaying ?? false }
    
    private let titleLabel = UILabel()
    private let playButton = UIButton()
    private let imageView = UIImageView()
    
    @IBAction func playButtonTapped(sender: UIButton!) {
        guard let audioURL = experience?.audioURL else { return }
        playAudioFile(URL: audioURL)
    }
    
    
    private func playAudioFile(URL: URL) {
        
        guard let url = experience?.audioURL else {
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
            fatalError("Error playing audio from popout")
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.setContentHuggingPriority(.defaultLow+1, for: .horizontal)
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true

        
        let placeTitleAndPlayButton = UIStackView(arrangedSubviews: [titleLabel, playButton])
        let imageViewStackView = UIStackView(arrangedSubviews: [imageView])
        
        placeTitleAndPlayButton.spacing = UIStackView.spacingUseSystem
        let mainStackView = UIStackView(arrangedSubviews: [placeTitleAndPlayButton, imageViewStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = UIStackView.spacingUseSystem
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func updateSubViews() {
        guard let experience = experience else { return }
        let title = experience.title
        titleLabel.text = title
        imageView.image = experience.image
    }
}

extension ExperienceDetailView: AVAudioPlayerDelegate {
    
}
