//
//  TermViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class TermViewController: BaseViewController {
    @IBOutlet weak var textView: UITextView!
    
    var presenter: ViewToPresenterTermProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar(title: "term_screen_header_title".Localizable(), isShowLeft: true)
        self.loadFile()
    }
    
    func loadFile() {
        if let rtfPath = Bundle.main.url(forResource: "term", withExtension: "rtf") {
           do {
               let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: rtfPath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
               self.textView.attributedText = attributedStringWithRtf
           } catch let error {
               print("Got an error \(error)")
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

}
    

extension TermViewController: PresenterToViewTermProtocol {
    
}
