//
//  UITableViewExtension.swift
//  Probit
//
//  Created by Beacon on 10/08/2022.
//

import Foundation
import UIKit

protocol CellButtonTappedDelegate: AnyObject {
    func connectBtnTapped(data: Any?)
}

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T>(cellType: T.Type) {
        let nib = UINib(nibName:String(describing: T.self), bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeaderFooter<T>(cellType: T.Type) {
        let nib = UINib(nibName:String(describing: T.self), bundle: Bundle.main)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type = T.self) throws -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.className) as? T else {
            let message = "Failed to dequeue a cell in table with identifier \(cellType.className) matching type \(cellType.self). "
            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
            + "and that you registered the cell beforehand"
            throw TypeCastingError.WrongTypeCasting(message: message)
        }
        return cell
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func dequeueReusableHeaderFooter<T: UIView>(_ cellType: T.Type = T.self) throws -> T {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: cellType.className) as? T else {
            let message = "Failed to dequeue a cell header footer in the table with identifier \(cellType.className) matching type \(cellType.self). "
            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
            + "and that you registered the cell beforehand"
            throw TypeCastingError.WrongTypeCasting(message: message)
        }
        return cell
    }
    
    func removeFooter() {
        self.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 1, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    func tableViewNoData(content: String? = nil, icons: String, colorString: String? = "#7B7B7B") -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: self.bounds.size.width,
                                        height: self.bounds.size.height))
        let label   = UILabel()
        label.text  = content
        label.font  = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: colorString ?? "#7B7B7B")
        label.textAlignment  = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        if icons.count > 0 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: icons)
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -45)
            ])
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                label.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30)
            ])
        } else {
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
            ])
        }
        return view
    }
    
    func setNoDataView(content: String?, icons: String) {
        self.backgroundView = tableViewNoData(content: content, icons: icons)
    }
    
    func removeNoDataView() {
        self.backgroundView = nil
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    func scrollToIndexPath(row: Int, section: Int, _ animated: Bool = false) {
        let indexPath = IndexPath(row: row, section: row)
        if hasRowAtIndexPath(indexPath: indexPath) {
            scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    
    func scrollToTop(_ animated: Bool = false) {
        self.scrollToIndexPath(row: 0, section: 0, animated)
    }
    
    func setEmptyView(title: String, message: String, messageImage: String, titleColor: UIColor? = UIColor.color_4231c8_6f6ff7, messageColor: UIColor? = UIColor.color_7b7b7b_fafafa, titleFont: UIFont? = UIFont(name: "SF Pro", size: 20), messageFont: UIFont? = UIFont(name: "SF Pro", size: 14)) {
        
        let emptyView = UIView(frame: CGRect(x: 16, y: 0, width: self.bounds.size.width - 32, height: self.bounds.size.height))
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = titleColor
        titleLabel.font = titleFont

        messageLabel.textColor = messageColor
        messageLabel.font = messageFont

        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -100).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 16).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = UIImage.init(named: messageImage)

        titleLabel.text = title
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}

