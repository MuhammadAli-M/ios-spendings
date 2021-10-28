//
//  DefaultTransactionRepository.swift
//  Spendings
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation

final class DefaultTransactionsRepository: TransactionsRepository{
    private let cache: TransactionsStorage
    
    init(cache: TransactionsStorage){
        self.cache = cache
    }
    
    func add(_ transaction: Transaction, completion: @escaping (Result<Transaction, Error>) -> Void) {
        
        cache.add(transaction) { result in
            completion(result)
        }
    }
    
    func fetchAll(completion: @escaping (Result<[Transaction], Error>) -> Void){
        cache.fetchAll(completion: { result in
            completion(result)
        })
    }
}
