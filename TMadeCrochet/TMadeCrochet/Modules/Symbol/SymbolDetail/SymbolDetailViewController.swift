//
//  SymbolDetailViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit
import AVKit

class SymbolDetailViewController: BaseViewController {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
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
                stackView.addArrangedSubview(StepView.init(title: step.stepName ?? "", imageName: step.imageName ?? ""))
            }
        }
    }
    
    @IBAction func playLocalVideo(_ sender: Any) {
           guard let path = Bundle.main.path(forResource: "SampleVideo", ofType: "mp4") else {
               return
           }
           let videoURL = NSURL(fileURLWithPath: path)

           // Create an AVPlayer, passing it the local video url path
           let player = AVPlayer(url: videoURL as URL)
           let controller = AVPlayerViewController()
           controller.player = player
           present(controller, animated: true) {
               player.play()
           }
       }
}
    

extension SymbolDetailViewController: PresenterToViewSymbolDetailProtocol {
    
}
