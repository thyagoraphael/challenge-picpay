//
//  UserIdsLegacy.swift
//  Interview
//
//  Created by Thyago Raphael on 10/05/23.
//  Copyright © 2023 PicPay. All rights reserved.
//

import Foundation

class UserIdsLegacy {
    static let legacyIds = [10, 11, 12, 13]
    
    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}
