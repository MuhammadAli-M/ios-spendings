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
    func availableCategories(completion: @escaping (Result<[Transaction.Category],Error>) -> Void)
}

struct AddTransactionUseCaseRequestValue{
    let transaction: Transaction
}

final class DefaultAddTransactionUseCase: AddTransactionUseCase{
    private let transactionsRepo: TransactionsRepository
    private let categoriesRepo: CategoriesRepository
    
    init(transactionsRepo: TransactionsRepository, categoriesRepo: CategoriesRepository){
        self.transactionsRepo = transactionsRepo
        self.categoriesRepo = categoriesRepo
    }
    
    func execute(request: AddTransactionUseCaseRequestValue, completion: @escaping (Result<Transaction, Error>) -> Void)  {
        
        return transactionsRepo.add(request.transaction) { result in
            return completion(result)
        }
    }
    
    func availableCategories(completion: @escaping (Result<[Transaction.Category], Error>) -> Void) {
        return categoriesRepo.fetchAll { result in
            completion(result)
        }
    }
}
