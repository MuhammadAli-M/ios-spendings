//
//  TransactionsListViewModel.swift
//  Spendings
//
//  Created by Muhammad Adam on 11/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

protocol TransactionsListViewModelInput {
    func viewDidLoad()
}

protocol TransactionsListViewModelOutput {
    
}

protocol TransactionsListViewModel: TransactionsListViewModelInput, TransactionsListViewModelOutput { }

class DefaultTransactionsListViewModel: TransactionsListViewModel {
    
    // MARK: - OUTPUT

}

// MARK: - INPUT. View event methods
extension DefaultTransactionsListViewModel {
    func viewDidLoad() {
    }
}
