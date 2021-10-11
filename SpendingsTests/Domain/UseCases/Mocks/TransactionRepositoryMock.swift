//
//  TransactionRepositoryMock.swift
//  SpendingsTests
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation
@testable import Spendings

class TransactionsRepositoryMock: TransactionsRepository{
    var transactions: [Transaction] = []
    func add(_ transaction: Transaction, completion: @escaping (Result<Transaction, Error>) -> Void) {
        transactions.append(transaction)
        completion(.success(transaction))
    }
    
    func fetchAll(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        completion(.success(transactions))
    }
    
}
