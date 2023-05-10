//
//  ViewCodeProtocol.swift
//  Interview
//
//  Created by Thyago Raphael on 10/05/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation

protocol ViewCodeProtocol {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeProtocol {
    func applyViewCode() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() { }
}
