//
//  SymbolDetailViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit
import AVKit
import YouTubePlayer

class SymbolDetailViewController: BaseViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var videoContainView: UIView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var playButton: UIButton!
    
    var presenter: ViewToPresenterSymbolDetailProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeButton.setTitle("", for: .normal)
        if let content = self.presenter?.symbol?.symbolDes {
            self.setupContentLabel(content: content)
        }
        if let steps = self.presenter?.symbol?.steps, steps.count > 0 {
            self.setupStackView(steps: steps)
        }
        self.playButton.setTitle("", for: .normal)
        self.playButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.loadVideo()
        self.startGoogleMobileAdsSDK()
    }
    
    func loadVideo() {
        if let videoUrl = self.presenter?.symbol?.videoUrl {
            videoPlayer.playerVars = [
                "controls" : "0",
                "showinfo" : "0",
                "autoplay": "0",
                "rel": "0",
                "modestbranding": "0",
                "iv_load_policy" : "3",
                "fs": "0",
                "playsinline" : "0"
                ] as YouTubePlayerView.YouTubePlayerParameters
            if let url = URL(string: videoUrl) {
                videoPlayer.loadVideoURL(url)
            }
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        self.showAds()
    }

    override func updateDataWhenAdsHiden() {
        if videoPlayer.ready {
            if videoPlayer.playerState != YouTubePlayerState.Playing {
                videoPlayer.play()
                self.playButton.isHidden = true
            } else {
                self.playButton.isHidden = false
                videoPlayer.pause()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setupContentLabel(content: String) {
        self.contentLabel.text = content
    }
    
    func setupStackView(steps: [SymbolStep]) {
        if steps.count > 0 {
            stackView.removeFullyAllArrangedSubviews()
            steps.forEach { step in
                stackView.addArrangedSubview(StepView.init(title: String.init(format: "%@: %@", step.stepName ?? "", step.content ?? ""), imageName: step.imageName ?? ""))
            }
        }
    }
}
    

extension SymbolDetailViewController: PresenterToViewSymbolDetailProtocol {
    
}
