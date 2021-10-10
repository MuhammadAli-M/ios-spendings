//
//  FetchAllTransactionsUseCase.swift
//  Spendings
//
//  Created by Muhammad Adam on 10/10/2021.
//

import Foundation

protocol FetchAllTransactionsUseCase {
    func execute(completion: @escaping (Result<[Transaction],Error>) -> Void)
}

final class DefaultFetchAllTransactionsUseCase: FetchAllTransactionsUseCase{
    private let transactionsRepo: TransactionsRepository
    
    init(transactionsRepo: TransactionsRepository){
        self.transactionsRepo = transactionsRepo
    }
    
    func execute(completion: @escaping (Result<[Transaction], Error>) -> Void)  {
        
        return transactionsRepo.fetchAll{ result in
            return completion(result)
        }
    }
}
