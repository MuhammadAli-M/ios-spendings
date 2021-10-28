//
//  TransactionsListVC.swift
//  Spendings
//
//  Created by Muhammad Adam on 11/10/2021.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

class TransactionsListVC: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TransactionsListViewModel!
    var addButton = UIButton()
    
    class func create(with viewModel: TransactionsListViewModel) -> TransactionsListVC {
        let vc = TransactionsListVC.instantiateViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind(to: viewModel)
        viewModel.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
        setupAddButton()
    }
    
    func setupAddButton(){
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 25
        
        guard let rootVC = self.view.window?.rootViewController /* UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController */ else{
            return
        }
        
        rootVC.view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.bottomAnchor.constraint(equalTo: rootVC.view.bottomAnchor, constant: -50),
            addButton.trailingAnchor.constraint(equalTo: rootVC.view.trailingAnchor, constant: -50),
        ])
        
        addButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
    }
    
    func bind(to viewModel: TransactionsListViewModel) {
        viewModel.transactions.observe(on: self) { [weak self] _ in self?.reload() }
    }
    
    func reload(){
        tableView.reloadData()
    }
    
    @objc func addBtnTapped(){
        viewModel.addBtnTapped()
    }
}

extension TransactionsListVC: UITableViewDelegate, UITableViewDataSource{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transactions.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier) as? TransactionTableViewCell else{
            debugLog("cell TransactionTableViewCell does not exist")
            return UITableViewCell()
        }
        
        cell.fill(with: viewModel.transactions.value[indexPath.row])
        
        return cell
    }
}
