//
//  TransactionsSceneFlowCoordinator.swift
//  Spendings
//
//  Created by Muhammad Adam on 12/10/2021.
//

import UIKit

protocol TransactionsSceneDependencies{
    func makeTransactionsListVC() -> TransactionsListVC
}

final class TransactionsSceneFlowCoordinator: Coordinator{
    
    private weak var navigationController: UINavigationController?
    private var dependencies: TransactionsSceneDependencies
    
    init(navigationController: UINavigationController, dependencies: TransactionsSceneDependencies){
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeTransactionsListVC()
        navigationController?.pushViewController(vc, animated: false)
    }

}
