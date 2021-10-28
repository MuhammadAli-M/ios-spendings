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
    
    
    // MARK: Outlets
    /*
     amount text field
     description text field
     add transaction button
     select category UI
        - button to show lits of categries
        - lable to show the selected category
     */
    @IBOutlet weak var amountTF: UITextField!
    
    @IBOutlet weak var notesTF: UITextField!
    
    @IBOutlet weak var selectedCategoryLbl: UILabel!
    
    @IBOutlet weak var selectCategoryBtn: UIButton!
    @IBOutlet weak var addTransactionBtn: UIButton!
    
    class func create(with viewModel: AddTransactionViewModel) -> AddTransactionVC {
        let vc = AddTransactionVC.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        // TODO: remove after completing
//        selectedCategoryLbl.text =
        
        
    }
    
    func bind(to viewModel: AddTransactionViewModel) {
        
    }
    
    // MARK: - Actions
    @IBAction func selectCategoryBtnTapped(_ sender: Any) {
        // TODO: remove after completing
        viewModel.didSelectCategory(category: .init(category: .init(name: "Food")))
    }
    
    @IBAction func addTransactionBtnTapped(_ sender: Any) {
        let note = notesTF.text ?? ""
        let date = Date()
        guard let amountString = amountTF.text,
              let amount = Float(amountString) else{
                  // TODO: handle failure
                  return
              }
        
        let trans = TransactionViewModel(amount: amount, note: note, date: date)
        viewModel.addTransactionTapped(transactionVM: trans) { result  in
            
            infoLog("result: \(result)")
            // TODO: handle result
            
        }
    }
}
