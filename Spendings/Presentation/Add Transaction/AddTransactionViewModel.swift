//
//  AddTransactionViewModel.swift
//  Spendings
//
//  Created by Muhammad Adam on 26/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

protocol AddTransactionViewModelInput {
    func viewDidLoad()
}

protocol AddTransactionViewModelOutput {
    
}

protocol AddTransactionViewModel: AddTransactionViewModelInput, AddTransactionViewModelOutput { }

class DefaultAddTransactionViewModel: AddTransactionViewModel {
    
    // MARK: - OUTPUT

}

// MARK: - INPUT. View event methods
extension DefaultAddTransactionViewModel {
    func viewDidLoad() {
    }
}
