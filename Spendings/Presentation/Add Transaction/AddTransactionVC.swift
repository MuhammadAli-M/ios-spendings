//
//  AddTransactionVC.swift
//  Spendings
//
//  Created by Muhammad Adam on 26/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class AddTransactionVC: UIViewController, StoryboardInstantiable {
    
    var viewModel: AddTransactionViewModel!
    
    class func create(with viewModel: AddTransactionViewModel) -> AddTransactionVC {
        let vc = AddTransactionVC.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    func bind(to viewModel: AddTransactionViewModel) {

    }
}
