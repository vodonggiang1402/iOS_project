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
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var videoContainView: UIView!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var playButton: UIButton!
    
    var presenter: ViewToPresenterSymbolDetailProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeButton.setTitle("", for: .normal)
        self.videoLabel.text = "symbol_detail_watch_video".Localizable()
        
        if let backgroundColor = self.presenter?.symbol?.backgroundColor {
            self.headerStackView.backgroundColor = UIColor(hexString: backgroundColor)
        }
        if let iconName = self.presenter?.symbol?.iconName, iconName.count > 0 {
            self.imageView.isHidden = false
            self.imageView.image = UIImage.init(named: iconName)
            self.nameLabel.textAlignment = .left
        } else {
            self.imageView.isHidden = true
            self.nameLabel.textAlignment = .center
        }
        
        if let name = self.presenter?.symbol?.symbolName {
            self.nameLabel.text = name.Localizable()
        }
        
        
        if let content = self.presenter?.symbol?.symbolDes, content.count > 0 {
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
        self.contentLabel.text = content.Localizable()
    }
    
    func setupStackView(steps: [SymbolStep]) {
        if steps.count > 0 {
            stackView.removeFullyAllArrangedSubviews()
            for (index, element) in steps.enumerated() {
                stackView.addArrangedSubview(StepView.init(title: String.init(format: "%@: %@", String.init(format:"step_text".Localizable(), index + 1), element.content?.Localizable() ?? ""), imageName: element.imageName?.Localizable() ?? ""))
            }
        }
    }
}
    

extension SymbolDetailViewController: PresenterToViewSymbolDetailProtocol {
    
}
