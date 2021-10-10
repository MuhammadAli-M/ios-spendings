//
//  Transaction.swift
//  Spendings
//
//  Created by Muhammad Adam on 09/10/2021.
//

import Foundation

struct Transaction: Equatable{
    let amount: Float
    let note: String
    let date: Date
    let category: Category
}

extension Transaction{
    struct Category: Equatable{
        let name: String
    }
}


