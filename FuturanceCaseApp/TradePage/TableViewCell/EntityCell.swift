//
//  TableViewCell.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 24.08.2022.
//

import UIKit

class EntityCell: UITableViewCell {
    static let cellID = "EntityCell"
    weak var delegate: EntityCellDelegate?
    var currency: CurrencyPresentation!
    private let tokenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let symbolStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.backgroundColor = .white
        return stack
    }()
    private let symbolStackVertical: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 3
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let symbolFirst: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    private let symbolSecond: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    private var symbolName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .gray
        return label
    }()
    private let trailingStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .darkGray
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var price: UILabel = {
        let label = UILabel()
        label.textColor = buttonGreen
        return label
    }()
    private var rateValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    private let rateStack: UIStackView = {
        let stack = UIStackView()
        stack.layer.cornerRadius = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let capsuleView: UIView = {
        let capsule = UIView()
        capsule.backgroundColor = .white
        capsule.translatesAutoresizingMaskIntoConstraints = false
        return capsule
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addTap()
        // symbols
        symbolStack.addArrangedSubview(symbolFirst)
        symbolStack.addArrangedSubview(symbolSecond)
        symbolStackVertical.addArrangedSubview(symbolStack)
        symbolStackVertical.addArrangedSubview(symbolName)
        // leading view
        capsuleView.addSubview(tokenImage)
        capsuleView.addSubview(symbolStackVertical)
        // trailing view
        trailingStack.addArrangedSubview(arrowImage)
        trailingStack.addArrangedSubview(price)
        // Capsule view
        rateStack.addArrangedSubview(rateValue)
        capsuleView.addSubview(trailingStack)
        addSubview(capsuleView)
        addSubview(rateStack)
        backgroundColor = background
        NSLayoutConstraint.activate([
            capsuleView.widthAnchor.constraint(equalTo: self.widthAnchor),
            capsuleView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -10),
            capsuleView.topAnchor.constraint(equalTo: self.topAnchor),
            capsuleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tokenImage.heightAnchor.constraint(equalTo: capsuleView.heightAnchor, constant: -10),
            tokenImage.widthAnchor.constraint(equalTo: tokenImage.heightAnchor),
            tokenImage.leadingAnchor.constraint(equalTo: capsuleView.leadingAnchor, constant: 20),
            tokenImage.centerYAnchor.constraint(equalTo: capsuleView.centerYAnchor),
            symbolStackVertical.heightAnchor.constraint(equalTo: capsuleView.heightAnchor, constant: -15),
            symbolStackVertical.topAnchor.constraint(equalTo: tokenImage.topAnchor),
            symbolStackVertical.leadingAnchor.constraint(equalTo: tokenImage.trailingAnchor, constant: 5),
            trailingStack.heightAnchor.constraint(equalTo: capsuleView.heightAnchor, multiplier: 0.5, constant: -5),
            trailingStack.topAnchor.constraint(equalTo: tokenImage.topAnchor),
            trailingStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            rateStack.heightAnchor.constraint(equalTo: capsuleView.heightAnchor, multiplier: 0.5, constant: -5),
            rateStack.bottomAnchor.constraint(equalTo: tokenImage.bottomAnchor),
            rateStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        capsuleView.layer.cornerRadius = 10
    }
    
    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func setCell(delegate: EntityCellDelegate, for currencyPresentation: CurrencyPresentation) {
        self.delegate = delegate
        currency = currencyPresentation
        symbolFirst.text = currencyPresentation.symbolFrom
        symbolSecond.text = "/\(currencyPresentation.symbolTo)"
        symbolName.text = currencyPresentation.name
        price.text = "\(currencyPresentation.lastPrice) ₺"
        let arrow: Arrow = currencyPresentation.priceChangePercent.isLess(than: 0) ? .downArrow : .upArrow
        price.textColor = arrow.color
        arrowImage.image = arrow.image
        rateStack.backgroundColor = arrow.color.withAlphaComponent(0.4)
        rateValue.text = currencyPresentation.priceChangePercent.isLess(than: 0) ?
        "  \(currencyPresentation.priceChangePercent)  " :
        "  +\(currencyPresentation.priceChangePercent)  "
        tokenImage.image = nil
        LogoCacher.shared.checkImage(for: currencyPresentation.symbolFrom, from: currencyPresentation.image) { image in
            DispatchQueue.main.async {
                self.tokenImage.image = image
            }
         
        }
    }
    
    @objc
    private func cellTapped(_ gesture: UIGestureRecognizer) {
        delegate?.cellPressed(currency)
    }
}
protocol EntityCellDelegate: AnyObject {
    func cellPressed(_ tappedCurrency: CurrencyPresentation)
    
}
