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
    
    init(){
        // TODO: Move it to somewhere else or encapsulate it
        let kRunBefore = "MA.Spendings.com.RunBefore"
        let runBefore = UserDefaults.standard.object(forKey: kRunBefore) as? Bool
        if runBefore != true {
            let categories = ["Food", "Home", "Transportations"]
            categories.forEach{ categoriesStorage.add(.init(name: $0)) { _ in } }
            UserDefaults.standard.set(true, forKey: kRunBefore)
        }
    }
    
}

extension TransactionsSceneDIContainer: TransactionsSceneDependencies{
    
    // Views
    func makeTransactionsListVC(actions: TransactionsListViewModelActions) -> TransactionsListVC {
        return TransactionsListVC.create(with: DefaultTransactionsListViewModel(fetchAllTransactionsUseCase: makeFetchAllTransactionsUseCase(),
                                                                                actions: actions))
    }
    
    func makeAddTransactionsVC(actions: AddTransactionViewModelActions) -> AddTransactionVC {
        return AddTransactionVC.create(with: DefaultAddTransactionViewModel(addTransactionUseCase: makeAddTransactionUseCase(),
                                                                            actions: actions))
    }
    
    // Coordinator
    func makeTransactionsSceneFlowCoordinator(navigationController: UINavigationController) -> TransactionsSceneFlowCoordinator{
        return TransactionsSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

