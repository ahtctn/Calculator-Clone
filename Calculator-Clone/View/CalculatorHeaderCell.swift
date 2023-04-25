//
//  CalculatorHeaderCell.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 25.04.2023.
//

import UIKit

class CalculatorHeaderCell: UICollectionReusableView {
    //MARK: HEADER ID
    static let id: String = "HeaderCell"
    
    //MARK: UI COMPONENTS
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.text = "header title label"
        return label
    }()
    
    //MARK: LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(currentCalculatorText: String) {
        self.label.text = currentCalculatorText
    }
    
    //MARK: UI SETUP
    private func setupUI() {
        self.backgroundColor = .black
        self.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
}
