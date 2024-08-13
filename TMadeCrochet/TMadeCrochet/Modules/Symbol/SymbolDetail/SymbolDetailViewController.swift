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

class SymbolDetailViewController: BaseViewController, YouTubePlayerDelegate {

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
    
    var isChangeData: Bool = false
    
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
        self.configVideo()
        self.loadVideo()
        self.startGoogleMobileAdsSDK()
    }
    
    func configVideo() {
        if self.isHideAdsButton() {
            self.playButton.isHidden = true
        } else {
            self.playButton.isHidden = false
            self.playButton.setTitle("", for: .normal)
            self.playButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
        
    }
    
    func isHideAdsButton() -> Bool {
        if let videoCount = self.presenter?.symbol?.videoCount, videoCount == 0 {
            return false
        }
        return true
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
        videoPlayer.delegate = self
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        self.showAds()
    }
    
    func updateVideoCount() {
        self.isChangeData = true
        if let symbolResponseData = AppConstant.symbolResponseData, var array = symbolResponseData.data, array.count > 0, let tempIndex = self.presenter?.currentIndexPath {
            if array[tempIndex.section].count > tempIndex.row, let videoCount = array[tempIndex.section][tempIndex.row].videoCount, videoCount < AppConstant.globalVideoCount {
                array[tempIndex.section][tempIndex.row].videoCount = (array[tempIndex.section][tempIndex.row].videoCount ?? 0) + 1
                self.playButton.isHidden = true
            } else {
                array[tempIndex.section][tempIndex.row].videoCount = 0
                self.playButton.isHidden = false
                self.playButton.setTitle("", for: .normal)
                self.playButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
            }
            AppConstant.symbolResponseData = SymbolResponseData.init(newData: array)
        }
    }

    override func updateDataWhenAdsHiden() {
        self.playVideo()
    }
    
    func playVideo() {
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
        if self.isChangeData {
            NotificationCenter.default
                .post(name: NSNotification.Name("com.tmadecrochet.reloadData"),
                      object: nil)
        }
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
    
    func playerReady(_ videoPlayer: YouTubePlayer.YouTubePlayerView) {
        
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayer.YouTubePlayerView, playerState: YouTubePlayer.YouTubePlayerState) {
        if playerState == .Paused || playerState == .Ended {
            self.updateVideoCount()
        }
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayer.YouTubePlayerView, playbackQuality: YouTubePlayer.YouTubePlaybackQuality) {
        
    }
}
    

extension SymbolDetailViewController: PresenterToViewSymbolDetailProtocol {
    
}
