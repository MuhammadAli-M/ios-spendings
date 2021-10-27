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
    func addBtnTapped()
}

protocol TransactionsListViewModelOutput {
    var transactions: Observable<[TransactionsListItemViewModel]> { get }
}

protocol TransactionsListViewModel: TransactionsListViewModelInput, TransactionsListViewModelOutput { }

class DefaultTransactionsListViewModel: TransactionsListViewModel {
    var transactions: Observable<[TransactionsListItemViewModel]> = .init( [.init(transaction: .init(amount: 5.0, note: "This is trial cell", date: Date(), category: .init(name: "Food")))] )

    
    
    // MARK: - OUTPUT

}

// MARK: - INPUT. View event methods
extension DefaultTransactionsListViewModel {
    func viewDidLoad() {
    }
    
    func addBtnTapped(){
        
    }
}

// MARK: - OUTPUT. View event methods
extension DefaultTransactionsListViewModel {
    

}



