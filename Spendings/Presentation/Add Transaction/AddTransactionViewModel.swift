//
//  AddTransactionViewModel.swift
//  Spendings
//
//  Created by Muhammad Adam on 26/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import UIKit

protocol AddTransactionViewModelInput {
    func viewDidLoad()
    func didSelectCategory(category: CategoryViewModel)
    func addTransactionTapped(transactionVM: TransactionViewModel, completion: @escaping (Result<Bool,TransactionValidationState>) -> Void)
}

protocol AddTransactionViewModelOutput {
    var availableCategories: Observable<[CategoryViewModel]> { get }
}

protocol AddTransactionViewModel: AddTransactionViewModelInput, AddTransactionViewModelOutput { }

class DefaultAddTransactionViewModel: AddTransactionViewModel {
    
    let addTransactionUseCase: AddTransactionUseCase

    // MARK: - OUTPUT
    let availableCategories: Observable<[CategoryViewModel]> = Observable([])
    let selectedCategory: Observable<CategoryViewModel?> = Observable(nil)
    
    // MARK: - Life Cycle
    init(addTransactionUseCase: AddTransactionUseCase) { // TODO: Add the actions for the navigation
        self.addTransactionUseCase = addTransactionUseCase
    }

    // MARK: Private
    // MARK: Error Handling
    private func handleFailedToGetAvaiableCategories(error: Error){
        // TODO: handle results
        errorLog("error: \(error.localizedDescription)")
    }
    

}

// MARK: - INPUT. View event methods
extension DefaultAddTransactionViewModel {
    func viewDidLoad() {
        addTransactionUseCase.availableCategories { [weak self] result in
            
            switch result{
            case .success(let categories):
                self?.availableCategories.value = categories.map{ CategoryViewModel(category: $0) }
            case .failure(let error):
                self?.handleFailedToGetAvaiableCategories(error: error)
            }
        }
    }
    
    func didSelectCategory(category: CategoryViewModel){
        selectedCategory.value = category
    }
    
    func addTransactionTapped(transactionVM: TransactionViewModel, completion: @escaping (Result<Bool,TransactionValidationState>) -> Void){
        
        guard let selectedCategoryValue = selectedCategory.value else {
            
            completion(.failure(.categoryNotSelected))
            return
        }
        
        let transaction = Transaction(amount: transactionVM.amount,
                                      note: transactionVM.note,
                                      date: transactionVM.date,
                                      category: .init(name: selectedCategoryValue.name))
        
        addTransactionUseCase.execute(request: .init(transaction: transaction)) { result  in
            switch result{
            case .success(_):
                completion(.success(true))
            case .failure(_):
                completion(.failure(.cacheFailure))  // TODO: reconsider it
            }
        }
        
        // TODO: handle validations
    }
}


struct CategoryViewModel: Equatable {
    let name: String
    
    init(category: Transaction.Category){
        self.name = category.name
    }
}

struct TransactionViewModel: Equatable {
    let amount: Float
    let note: String
    let date: Date
//    let category: CategoryViewModel
    
    static func validate(amount: Float) -> TransactionValidationState{
        if amount < 0 {
            return .amountNegativeValue
        }
        return .valid // TODO: update
    }
}

fileprivate extension TransactionViewModel {
init(transaction: Transaction){
    self.amount = transaction.amount
    self.note = transaction.note
    self.date = transaction.date
//        self.category = .init(category: transaction.category)
    
//    func toDomain() -> Transaction{
//        Transaction(amount: <#T##Float#>,
//                    note: <#T##String#>,
//                    date: <#T##Date#>,
//                    category: <#T##Transaction.Category#>)
//    }
}

}
enum TransactionValidationState: Error{
    case valid
    case amountNegativeValue
    case categoryNotSelected
    case cacheFailure
}
