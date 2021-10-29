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
    @IBOutlet weak var amountTF: UITextField!{
        didSet { amountTF?.addDoneCancelToolbar() }
    }
    
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
        setupViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
        // TODO: remove after completing
//        selectedCategoryLbl.text =
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTF.keyboardType = .numberPad
        amountTF.returnKeyType = .done
        amountTF.becomeFirstResponder()
    }
    func bind(to viewModel: AddTransactionViewModel) {
        
    }
    
    func setupViews(){
        amountTF.delegate = self
        notesTF.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func selectCategoryBtnTapped(_ sender: Any) {
        let categories = viewModel.availableCategories.value
        
        let actions = categories.map{
            UIAlertAction(title: $0.name, style: .default) { [weak self] action in
                if let cat = categories.first(where: { $0.name == action.title }){
                    self?.selectedCategoryLbl.text = cat.name
                    self?.viewModel.didSelectCategory(category: cat)
                }
            }
        }
        
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // add actions
        actions.forEach({ actionSheetController.addAction($0) })

//        actionSheetController.popoverPresentationController?.sourceView = yourSourceViewName // works for both iPhone & iPad

        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
        
        // TODO: remove after completing
//        viewModel.didSelectCategory(category: .init(category: .init(name: "Food")))
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
        viewModel.addTransactionTapped(transactionVM: trans) { [weak self] result  in
            
            infoLog("result: \(result)")
            // TODO: handle result
            
            switch result{
            case.success(let transaction): break
            case .failure(let validation): break
            }
            
        }
    }
}

// MARK: - UITextFieldDelegate
extension AddTransactionVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === amountTF{
            amountTF.resignFirstResponder()
            notesTF.becomeFirstResponder()
        }else if textField === notesTF{
            notesTF.resignFirstResponder()
        }
    }
}



