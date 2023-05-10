//
//  ViewCodeProtocol.swift
//  Interview
//
//  Created by Thyago Raphael on 10/05/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation

protocol ViewCodeProtocol {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewCodeProtocol {
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
    
    func applyAdditionalChanges() { }
}
