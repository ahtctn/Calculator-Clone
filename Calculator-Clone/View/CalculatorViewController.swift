//
//  ViewController.swift
//  Calculator-Clone
//
//  Created by Ahmet Ali ÇETİN on 22.04.2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    //MARK: PROPERTIES
    let viewModel: CalculatorViewModel

    //MARK: UI COMPONENTS
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.register(CalculatorHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CalculatorHeaderCell.id)
        collection.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: ButtonCollectionViewCell.id)
        return collection
        
    }()
    
    //MARK: INITIALIZERS
    init(viewModel: CalculatorViewModel = CalculatorViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        setupUI()
        delegations()
    }
    
    //MARK: FUNCTIONS
    private func delegations() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //MARK: UI SETUP
    private func setupUI() {
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

extension CalculatorViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: SECTION HEADER CELL
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalculatorHeaderCell.id, for: indexPath) as? CalculatorHeaderCell else {
            fatalError("Failed to dequeue CalculatorHeaderCell in CalculatorViewController")
        }
        header.configure(currentCalculatorText: self.viewModel.calculatorHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let totalCellHeight = view.frame.size.width
        let totalVerticalCellSpacing = CGFloat(10 * 4)
        
        let window = view.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        
        let availibleScreenHeight = view.frame.size.height - topPadding - bottomPadding
        
        let headerHeight = (availibleScreenHeight - totalCellHeight) - totalVerticalCellSpacing
        return CGSize(width: view.frame.size.width, height: headerHeight)
    }
    
     
    //MARK: NORMAL CELLS (BUTTONS)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calculatorButtonCells.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.id, for: indexPath) as? ButtonCollectionViewCell else {
            fatalError("Unable to dequeue ButtonCell in Calculator Controller.")
            
        }
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        cell.configure(with: calculatorButton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        
        switch calculatorButton {
        case let .number(int) where int == 0:
            return CGSize(
                width: ((view.frame.size.width / 5) * 2) + ((view.frame.self.width / 5) / 3),
                height: (view.frame.size.width / 5)
            )
        default:
            return CGSize(
                width: (view.frame.size.width / 5),
                height: (view.frame.size.width / 5)
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ((self.view.frame.width / 5) / 3.1)
            
    }
    
    //MARK: SİLİNEBİLİR
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = self.viewModel.calculatorButtonCells[indexPath.row]
        print(buttonCell.title)
    }
}
