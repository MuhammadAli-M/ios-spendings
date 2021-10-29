//
//  TransactionTableViewCell.swift
//  Spendings
//
//  Created by Muhammad Adam on 12/10/2021.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    typealias ViewModel = TransactionsListItemViewModel
    static let reuseIdentifier = "TransactionTableViewCell"
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var detailsStack: UIStackView!
    @IBOutlet weak var amountLabel: UILabel!
    
    private var viewModel: ViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: Handle it so you only edit views not add then remove with each reuse
        self.detailsStack.subviews.forEach { $0.removeFromSuperview()}
    }
    
    func fill(with model:ViewModel){
        addCategory(title: model.category)
        self.amountLabel.text = model.amount
        if let note = model.note{
            addNote(note)
        }
        self.categoryImageView.image = model.image
    }
    
    fileprivate func addCategory(title: String){
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 14.0)
            return label
        }()
        titleLabel.text = title
        detailsStack.addArrangedSubview(titleLabel)
    }
    
    fileprivate func addNote(_ note: String){
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 14.0)
            return label
        }()
        titleLabel.text = note
        detailsStack.addArrangedSubview(titleLabel)
    }
}

