//
//  TransactionsSceneFlowCoordinator.swift
//  Spendings
//
//  Created by Muhammad Adam on 12/10/2021.
//

import UIKit

protocol TransactionsSceneDependencies{
    func makeTransactionsListVC(actions : TransactionsListViewModelActions) -> TransactionsListVC
    func makeAddTransactionsVC(actions : AddTransactionViewModelActions) -> AddTransactionVC
}

final class TransactionsSceneFlowCoordinator: Coordinator{
    
    private weak var navigationController: UINavigationController?
    private var dependencies: TransactionsSceneDependencies
    
    init(navigationController: UINavigationController, dependencies: TransactionsSceneDependencies){
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = TransactionsListViewModelActions(showAddTranaction: showAddTranaction)
        
        let vc = dependencies.makeTransactionsListVC(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showAddTranaction(){
        let actions = AddTransactionViewModelActions(showTransactionsList: showTransactionsList)
        let vc = dependencies.makeAddTransactionsVC(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTransactionsList(){
        navigationController?.popViewController(animated: true)
    }

}
