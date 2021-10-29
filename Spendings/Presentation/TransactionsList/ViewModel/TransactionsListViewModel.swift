//
//  TransactionsListViewModel.swift
//  Spendings
//
//  Created by Muhammad Adam on 11/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

struct TransactionsListViewModelActions {
    let showAddTranaction: () -> Void
}


protocol TransactionsListViewModelInput {
    func viewDidLoad()
    func viewDidAppear()
    func addBtnTapped()
    var total: Observable<Double> { get }
}

protocol TransactionsListViewModelOutput {
    var transactions: Observable<[TransactionsListItemViewModel]> { get }
}

protocol TransactionsListViewModel: TransactionsListViewModelInput, TransactionsListViewModelOutput { }

class DefaultTransactionsListViewModel: TransactionsListViewModel {
    
    let fetchAllTransactionsUseCase: FetchAllTransactionsUseCase
    var actions: TransactionsListViewModelActions? = nil
    // MARK: - Life Cycle
    init(fetchAllTransactionsUseCase: FetchAllTransactionsUseCase, actions: TransactionsListViewModelActions? = nil) {
        self.actions = actions
        self.fetchAllTransactionsUseCase = fetchAllTransactionsUseCase
    }
    
    // MARK: - OUTPUT
    var transactions: Observable<[TransactionsListItemViewModel]> = .init([])
    var total: Observable<Double> = .init(0)

    // MARK: - Private
    fileprivate func fetchAllTransactions() {
        fetchAllTransactionsUseCase.execute { [weak self] result in
            switch result{
            case .success(let trans):
                self?.transactions.value = []
                self?.total.value = 0
                for transaction in trans{
                    self?.transactions.value.append(TransactionsListItemViewModel(transaction: transaction))
                    self?.total.value += Double(transaction.amount)
                }
//                self?.transactions.value = trans.map{ TransactionsListItemViewModel(transaction: $0) }
//                self?.total.value = trans.value
            case .failure(let error):
                errorLog("failure: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - INPUT. View event methods
extension DefaultTransactionsListViewModel {
    
    func viewDidLoad() {
        fetchAllTransactions()
    }
    
    func viewDidAppear(){
        fetchAllTransactions()
    }
    
    func addBtnTapped(){
        actions?.showAddTranaction()
    }
}

// MARK: - OUTPUT. View event methods
extension DefaultTransactionsListViewModel {
    

}



