//
//  AddTransactionUseCase.swift
//  Spendings
//
//  Created by Muhammad Adam on 09/10/2021.
//

import Foundation

protocol AddTransactionUseCase {
    func execute(request: AddTransactionUseCaseRequestValue,
                 completion: @escaping (Result<Transaction,Error>) -> Void)
}

struct AddTransactionUseCaseRequestValue{
    let transaction: Transaction
}

final class DefaultAddTransactionUseCase: AddTransactionUseCase{
    private let transactionsRepo: TransactionsRepository
    
    init(transactionsRepo: TransactionsRepository){
        self.transactionsRepo = transactionsRepo
    }
    
    func execute(request: AddTransactionUseCaseRequestValue, completion: @escaping (Result<Transaction, Error>) -> Void)  {
        
        return transactionsRepo.add(request.transaction) { result in
            return completion(result)
        }
    }
}
