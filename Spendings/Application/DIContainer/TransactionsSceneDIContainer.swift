//
//  TransactionsSceneDIContainer.swift
//  Spendings
//
//  Created by Muhammad Adam on 11/10/2021.
//

import UIKit

final class TransactionsSceneDIContainer {
    
    // MARK: Storages
    lazy var transactionsStorage: TransactionsStorage = UserDefaultsTransactionsStorage()

    
    lazy var transactionsRepository: TransactionsRepository = DefaultTransactionsRepository(cache: transactionsStorage)
    
    // MARK: Use Cases
    func makeAddTransactionUseCase() -> AddTransactionUseCase{
        return DefaultAddTransactionUseCase(transactionsRepo: transactionsRepository)
    }
    
    func makeFetchAllTransactionsUseCase() -> FetchAllTransactionsUseCase{
        return DefaultFetchAllTransactionsUseCase(transactionsRepo: transactionsRepository)
    }
    
}

extension TransactionsSceneDIContainer: TransactionsSceneDependencies{
    
    // Views
    func makeTransactionsListVC() -> TransactionsListVC {
        return TransactionsListVC.create(with: DefaultTransactionsListViewModel())
    }
    
    // Coordinator
    func makeTransactionsSceneFlowCoordinator(navigationController: UINavigationController) -> TransactionsSceneFlowCoordinator{
        return TransactionsSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

