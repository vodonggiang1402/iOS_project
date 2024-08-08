//
//  ListTutorialCollectionCell.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 2/8/24.
//

import Foundation
import UIKit
import YouTubePlayer

class ListTutorialCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadVideo(linkId: String) {
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
        if let url = URL(string: "https://youtu.be/\(linkId)") {
            videoPlayer.loadVideoURL(url)
        }
    }
    
    override func setupCell(object: Any) {
        guard let model = object as? TutorialItem else { return }
        self.titleLabel.text = model.itemName?.Localizable()
        self.desLabel.text = model.itemDes?.Localizable()
        self.loadVideo(linkId: model.itemUrl ?? "")
    }
}
