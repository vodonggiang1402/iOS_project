//
//  SymbolDetailViewController.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class SymbolDetailViewController: BaseViewController {
    @IBOutlet weak var closeButton: UIButton!
    var presenter: ViewToPresenterSymbolDetailProtocol?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeButton.setTitle("", for: .normal)
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
}
    

extension SymbolDetailViewController: PresenterToViewSymbolDetailProtocol {
    
}
