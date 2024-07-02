//
//  BaseView.swift
//  Probit
//
//  Created by Beacon on 10/08/2022.
//

import UIKit

@IBDesignable class BaseView: UIView {
    // MARK: View used for init from nib
    internal var contentView: UIView!

    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        xibSetup()
    }
    
    deinit {
        self.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        self.contentView?.removeConstraints(self.contentView.constraints)
        self.contentView = nil
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
    }

    // MARK: - Show on super view
    func addToWindow() {
        UIApplication.shared.windows.last?.addSubview(self)
    }

    // MARK: - Setup Xib

    private func xibSetup() {
        do {
            contentView = try loadViewFromNib()
            addSubview(contentView)
            
            // Adding custom subview on top of our view (over any custom drawing > see note below)
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            
            // Set contraints to full view
            NSLayoutConstraint.activate([
                self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
                self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
            setupUI()
            localizedString()
        } catch (let error) {
            print("error", error)
        }
    }
    
    func localizedString() { }
    
    func setupUI() { }
    
    internal func getNibName() -> String {
        return ""
    }

    private func loadViewFromNib() throws -> UIView {
        var name = getNibName()
        if name.isEmpty {
            name = String(describing: type(of: self))
        }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        // Assumes UIView is top level and only object in CustomView.xib file
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            throw TypeCastingError.NilResult
        }
        return view
    }

    public func setBackgroundColor(color: UIColor?) {
        contentView.backgroundColor = color
    }
}
