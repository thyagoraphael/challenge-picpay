//
//  ContactCellViewModel.swift
//  Interview
//
//  Created by Thyago Raphael on 10/05/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation

final class ContactCellViewModel {
    private var model: ContactModel
    
    init(model: ContactModel) {
        self.model = model
    }
    
    func showID() -> Int { self.model.id }
    
    func showName() -> String { self.model.name }
    
    func showPhotoURL() -> URL? {
        URL(string: self.model.photoURL)
    }
}
