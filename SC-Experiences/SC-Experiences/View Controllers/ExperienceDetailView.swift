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
            setUpButton()
            updateSubViews()
        }
    }
    
    
    var player: AVAudioPlayer?
    
    var isPlaying: Bool { return player?.isPlaying ?? false }
    
    private let titleLabel = UILabel()
    private let playButton = UIButton()
    private let imageView = UIImageView()
    
    
    func setUpButton() {
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    @objc func playButtonTapped() {
        guard let url = experience?.audioURL else { return }
        playAudioFile(url: url)
    }
    
    private func playAudioFile(url: URL) {
        
        
        guard !isPlaying else {
            player?.stop()
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            print("\(url)")
            player?.delegate = self
            player?.play()
            updateSubViews()
        } catch {
            fatalError("Error playing audio from popout")
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.setContentHuggingPriority(.defaultLow+1, for: .horizontal)
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor, multiplier: 0.2).isActive = true
        playButton.backgroundColor = .systemBlue
        
        let placeTitleAndPlayButton = UIStackView(arrangedSubviews: [playButton])
        placeTitleAndPlayButton.axis = .horizontal
        let imageViewStackView = UIStackView(arrangedSubviews: [imageView])
        
      placeTitleAndPlayButton.spacing = UIStackView.spacingUseSystem
        let mainStackView = UIStackView(arrangedSubviews: [imageViewStackView, placeTitleAndPlayButton])
        mainStackView.axis = .vertical
        mainStackView.spacing = UIStackView.spacingUseSystem
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        updateSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateSubViews() {
        guard let experience = experience else { return }
        let title = experience.title
        titleLabel.text = title
        imageView.image = experience.image
        if isPlaying {
            playButton.setTitle("Pause", for: .normal)
        } else {
            playButton.setTitle("Play", for: .normal)
        }
    }
}

extension ExperienceDetailView: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateSubViews()
    }
}
