//
//  AppFlowCoordinator.swift
//  Spendings
//
//  Created by Muhammad Adam on 11/10/2021.
//

import UIKit

final class AppFlowCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navigationController: UINavigationController, appDIContainer: AppDIContainer){
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let flow = TransactionsSceneDIContainer().makeTransactionsSceneFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}


protocol Coordinator{
    func start()
}



