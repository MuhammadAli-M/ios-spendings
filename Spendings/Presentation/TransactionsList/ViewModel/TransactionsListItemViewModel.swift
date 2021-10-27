//
//  TransactionsListItemViewModel.swift
//  Spendings
//
//  Created by Muhammad Adam on 12/10/2021.
//

import UIKit

struct TransactionsListItemViewModel{
    let category: String
    let amount: String
    let date: String
    let note: String?
    let image: UIImage?
    
    init(transaction: Transaction){
        self.amount = String(transaction.amount)
        self.note = transaction.note
        self.date = dateFormatter.string(from: transaction.date)
        self.category = transaction.category.name
        self.image = UIImage(systemName: "checkmark.diamond")  // TODO: to be changed
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
}
