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
    lazy var categoriesStorage: CategoriesStorage = UserDefaultCategoriesStorage(key: "UserDefaultCategoriesStorage") // TODO: fix this init
    
    lazy var transactionsRepository: TransactionsRepository = DefaultTransactionsRepository(cache: transactionsStorage)
    lazy var categoriesRepository: CategoriesRepository = DefaultCategoryRepository(cache: categoriesStorage)

    // MARK: Use Cases
    func makeAddTransactionUseCase() -> AddTransactionUseCase{
        return DefaultAddTransactionUseCase(transactionsRepo: transactionsRepository,
                                            categoriesRepo: categoriesRepository)
    }
    
    func makeFetchAllTransactionsUseCase() -> FetchAllTransactionsUseCase{
        return DefaultFetchAllTransactionsUseCase(transactionsRepo: transactionsRepository)
    }
    
}

extension TransactionsSceneDIContainer: TransactionsSceneDependencies{
    
    // Views
    func makeTransactionsListVC(actions: TransactionsListViewModelActions) -> TransactionsListVC {
        return TransactionsListVC.create(with: DefaultTransactionsListViewModel(fetchAllTransactionsUseCase: makeFetchAllTransactionsUseCase(),
                                                                                actions: actions))
    }
    
    func makeAddTransactionsVC() -> AddTransactionVC {
        return AddTransactionVC.create(with: DefaultAddTransactionViewModel(addTransactionUseCase: makeAddTransactionUseCase()))
    }
    
    // Coordinator
    func makeTransactionsSceneFlowCoordinator(navigationController: UINavigationController) -> TransactionsSceneFlowCoordinator{
        return TransactionsSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

