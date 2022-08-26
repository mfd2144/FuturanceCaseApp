//
//  TradeViewController.swift
//  FuturanceCaseApp
//
//  Created by Mehmet fatih DOĞAN on 22.08.2022.
//

import UIKit


final class TradeView: UIViewController {
    // MARK: - Properties
    var presenter: TradePresenterProtocol!
    private var buttonString: String! {
        didSet {
            mainButton.setTitle(buttonString, for: .normal)
        }
    }
    private var currencyPresantations = [CurrencyPresentation]()
    let restScreenHeight = screenHeight - topSafeArea - 10 - bottomSafeArea
    
    let refreshController: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Al", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = buttonGreen
        return button
    }()
    let sellButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sat", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.backgroundColor = darkGray
        return button
    }()
    let tradeButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let mainButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = buttonGreen
        return button
    }()
    let textFieldCoin: UITextField = {
        let field = UITextField()
        field.backgroundColor = darkGray
        field.setLeftPaddingPoints(20)
        field.layer.cornerRadius = 10
        return field
    }()
    let coinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let textFieldTRY: UITextField = {
        let field = UITextField()
        field.backgroundColor = darkGray
        field.setLeftPaddingPoints(20)
        field.layer.cornerRadius = 10
        return field
    }()
    let labelHighValue: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let labelLowValue: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let labelHighStatic: UILabel = {
        let label = UILabel()
        label.text = "24s Yüksek"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let labelLowStatic: UILabel = {
        let label = UILabel()
        label.text = "24s Düşük"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 5
        stack.axis = .horizontal
        return stack
    }()
    let highRateStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    let lowRateStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.axis = .vertical
        return stack
    }()
    let rateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    let walletImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "wallet")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    let amountInWallet: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        let wallet = WalletManager.shared.myWallet.value.entities
        label.text = "\( wallet.first!.amount) \( wallet.first!.name) "
        
        return label
    }()
    let walletStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 5
        stack.axis = .horizontal
        return stack
    }()
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
}
extension TradeView {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        presenter.load()
        addSubviews()
        setNavigationBar()
        setButton()
        setTableView()
        buttonString = "AL"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buyButton.layer.cornerRadius = buyButton.frame.height / 2
        sellButton.layer.cornerRadius = sellButton.frame.height / 2
        mainButton.layer.cornerRadius = mainButton.frame.height / 2
    }
    // MARK: - Functions
    private func setView() {
        view.keyboardSwipeView()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = background
    }
    private func setButton() {
        buyButton.addTarget(self, action: #selector(buyButtonPressed(_:)), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(sellButtonPressed(_:)), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(mainButtonPressed), for: .touchUpInside)
    }
    private func addSubviews() {
        // sell and buy button
        tradeButtonsStack.addArrangedSubview(buyButton)
        tradeButtonsStack.addArrangedSubview(sellButton)
        // 24h High
        highRateStack.addArrangedSubview(labelHighStatic)
        highRateStack.addArrangedSubview(labelHighValue)
        // 24h low
        lowRateStack.addArrangedSubview(labelLowStatic)
        lowRateStack.addArrangedSubview(labelLowValue)
        // rates stack
        rateStack.addArrangedSubview(highRateStack)
        rateStack.addArrangedSubview(lowRateStack)
        // 1.top stack
        buttonStack.addArrangedSubview(tradeButtonsStack)
        buttonStack.addArrangedSubview(rateStack)
        // 2. wallet stack
        walletStack.addArrangedSubview(walletImage)
        walletStack.addArrangedSubview(amountInWallet)
        // main stack
        mainStack.addArrangedSubview(buttonStack)
        mainStack.addArrangedSubview(walletStack)
        mainStack.addArrangedSubview(textFieldCoin)
        mainStack.addArrangedSubview(textFieldTRY)
        mainStack.addArrangedSubview(emptyView)
        mainStack.addArrangedSubview(mainButton)
        // main view
        view.addSubview(mainStack)
        view.addSubview(tableView)
        textFieldCoin.addSubview(coinLabel)
        setSubviews()
    }
    private func setSubviews() {
        // custom navBar is higher 10 point more than normal
        // I measured heights to Case image
        // with using height rates I
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: screenWidth - 30),
            tableView.heightAnchor.constraint(equalToConstant: restScreenHeight / 3.65 ),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (10 + restScreenHeight / 10) - restScreenHeight),
            mainStack.widthAnchor.constraint(equalToConstant: screenWidth - 30),
            mainStack.heightAnchor.constraint(equalToConstant: restScreenHeight / 2.7),
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * (restScreenHeight / 9.5)),
            coinLabel.widthAnchor.constraint(equalToConstant: screenWidth / 3),
            coinLabel.heightAnchor.constraint(equalTo: textFieldCoin.heightAnchor),
            coinLabel.centerYAnchor.constraint(equalTo: textFieldCoin.centerYAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenWidth / 2 ),
            walletImage.widthAnchor.constraint(equalTo: walletImage.heightAnchor)
        ])
        print(buttonStack.frame.height)
    }
    
    private func setNavigationBar() {
        // Add BarButtons and colors
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(backButtonPressed))
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closePressed))
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = background
        // Set Navigation custom title
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = background
        titleLabel.text = "iOS Test Case"
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.alignment = .center
        stackView.backgroundColor = navigationPurple
        // This will assing your custom view to navigation title.
        navigationItem.titleView = stackView
        // Add view with corner radious
        let navheight = navigationController!.navigationBar.bounds.height
        let frame = CGRect(x: 0, y: 0, width: screenWidth, height: navheight + topSafeArea + 10)
        let navBottom = UIView(frame: frame)
        navBottom.backgroundColor = background
        let cornerLayer = CAShapeLayer()
        cornerLayer.path = UIBezierPath(roundedRect: navBottom
            .bounds, byRoundingCorners: [.bottomLeft, .bottomRight ], cornerRadii: CGSize(width: 30, height: 30))
        .cgPath
        cornerLayer.fillColor = navigationPurple.cgColor
        navBottom.layer.insertSublayer(cornerLayer, at: 1)
        view.addSubview(navBottom)
    }
    @objc
    private func backButtonPressed() {
        print("geri düğmesine basıldı")
    }
    @objc
    private func closePressed() {
        print("kapama düğmesine basıldı")
    }
    @objc
    private func buyButtonPressed(_ sender: UIButton) {
        presenter.buyPressed()
    }
    @objc
    private func sellButtonPressed(_ sender: UIButton) {
        presenter.sellPressed()
    }
    @objc
    private func refresh() {
        presenter.refreshPressed()
    }
    @objc
    private func mainButtonPressed() {
        presenter.mainButtonPressed()
    }
}
extension TradeView: UITableViewDelegate, UITableViewDataSource, EntityCellDelegate {
    // Set delegate datasource and other properties about tableview
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EntityCell.self, forCellReuseIdentifier: EntityCell.cellID)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        let tableHeight = restScreenHeight / 3.65
        tableView.rowHeight = 30 + (tableHeight / 8)
        refreshController.attributedTitle = NSAttributedString(string: "Fiyatlar Güncelleniyor...", attributes: [NSAttributedString.Key.foregroundColor: buttonGreen, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .heavy)])
        refreshController.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshController)
    }
    
    func cellPressed(_ currencyTapped: CurrencyPresentation) {
        presenter.cellSelected(currencyTapped)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyPresantations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EntityCell.cellID, for: indexPath) as? EntityCell else { fatalError("reusable cell error") }
        cell.setCell(delegate: self, for: currencyPresantations[indexPath.row])
        return cell
    }
}
// MARK: - TradeViewProtocol
extension TradeView: TradeViewProtocol {
    func handleOutputs(_ outputs: TradePresenterOutputs) {
        switch outputs {
        case .isLoading(let isLoading):
            print(isLoading)
        case .returnCurrenciesData(let currencies):
            DispatchQueue.main.async {
                self.currencyPresantations = currencies
                self.tableView.reloadData()
            }
        case .anyError(let errorString):
            print(errorString)
        case .totalEntity(let myWallet):
            print(myWallet)
        case .afterSelectedButtonChange( let selectedButton):
            setAfterButtonSelect(button: selectedButton)
        case .afterCoinSelected(let coin):
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
                            self?.labelHighValue.text = "\(coin.highPrice)"
                            self?.labelLowValue.text = "\(coin.lowPrice)"
                            self?.coinLabel.text = "\(coin.symbolFrom) Miktarı"
                           if let count = self?.buttonString.split(separator: " ").count, count > 1 {
                               guard let lastPart = self?.buttonString.split(separator: " ").last else { return }
                               self?.buttonString = "\(coin.symbolFrom) \(lastPart)"
                           } else {
                               self?.buttonString = "\(coin.symbolFrom) \(String(describing: self?.buttonString!))"
                           }
            
                        }
        }
    }
    private func setAfterButtonSelect(button: SelectedButton) {
        let logic = button == .buy ? true : false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.buyButton.backgroundColor = logic ? buttonGreen : darkGray
            self.buyButton.setTitleColor(logic ? .white : .darkGray, for: .normal)
            self.sellButton.backgroundColor = logic ? darkGray : buttonRed
            self.sellButton.setTitleColor(logic ? .darkGray : .white, for: .normal)
            self.mainButton.backgroundColor = logic ? buttonGreen : buttonRed
            if self.buttonString.contains("SAT") {
                self.buttonString = self.buttonString.replacingOccurrences(of: "SAT", with: "AL")
            } else if self.buttonString.contains("AL") {
                self.buttonString = self.buttonString.replacingOccurrences(of: "AL", with: "SAT")
            }
        }
    }
}
