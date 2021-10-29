//
//  AppDIContainer.swift
//  Spendings
//
//  Created by Muhammad Adam on 12/10/2021.
//

import Foundation

final class AppDIContainer{
    
    func makeTransactionsSceneDIContainer() -> TransactionsSceneDIContainer{
        return TransactionsSceneDIContainer()
    }
}
