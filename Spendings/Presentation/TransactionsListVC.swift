//
//  TransactionsListViewController.swift
//  Spendings
//
//  Created by Muhammad Adam on 11/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class TransactionsListVC: UIViewController, StoryboardInstantiable {
    
    var viewModel: TransactionsListViewModel!
    
    class func create(with viewModel: TransactionsListViewModel) -> TransactionsListVC {
        let vc = TransactionsListVC.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to viewModel: TransactionsListViewModel) {

    }
}
