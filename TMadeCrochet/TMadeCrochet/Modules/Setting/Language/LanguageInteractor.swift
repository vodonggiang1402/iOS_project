//
//  LanguageInteractor.swift
//  Probit
//
//  Created by Vo Dong Giang on 14/09/2023.
//

import Foundation
import UIKit

class LanguageInteractor: PresenterToInteractorLanguageProtocol {
    var presenter: InteractorToPresenterLanguageProtocol?
    var entity: InteractorToEntityLanguageProtocol?
    var languageAppSetting: [Language] = []
    
    deinit {
        self.presenter = nil
    }
    
    func getData() {
        let langIds = Bundle.main.localizations
        var languages = [Language]()
        for langId in langIds {
            let loc = Locale(identifier: langId)
            if let fullName = loc.localizedString(forIdentifier: langId),
               let normalName = fullName.components(separatedBy: " (").first,
               let name = normalName.components(separatedBy: "（").first {
                let object = Language(id: langId,
                                      name: name,
                                      isSelected: langId == AppConstant.localeId)
                languages.append(object)
            }
        }
        languageAppSetting = languages.sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
        if let enIndex = languageAppSetting.firstIndex(where: {$0.id == "vi"}) {
            languageAppSetting.rearrange(fromIndex: enIndex, toIndex: 0)
        }
        self.presenter?.dataListDidFetch()
    }
    
    func changeLanguage(indexPath: IndexPath) {
        let item = languageAppSetting[indexPath.item]
        AppConstant.localeId = item.id
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.setRootScreen()
        }
    }
}
