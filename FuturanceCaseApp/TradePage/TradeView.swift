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
    private var selectedButton: SelectedButton = .buy
    private var selectedCurrency: CurrencyPresentation!
    private var gesture: UITapGestureRecognizer!
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
        field.keyboardType = .decimalPad
        field.layer.cornerRadius = 10
        return field
    }()
    let coinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.minimumScaleFactor = 0.7
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let textFieldTRY: UITextField = {
        let field = UITextField()
        field.backgroundColor = darkGray
        field.keyboardType = .decimalPad
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
        label.font = .systemFont(ofSize: 10, weight: .black)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let labelLowStatic: UILabel = {
        let label = UILabel()
        label.text = "24s Düşük"
        label.font = .systemFont(ofSize: 10, weight: .black)
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
        imageV.image = UIImage(named: "wallet")?
            .withTintColor(.gray, renderingMode: .alwaysOriginal)
            .withAlignmentRectInsets(.init(top: -5, left: 0, bottom: -5, right: 0))
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    let walletLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.text = "Bakiye"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let amountInWallet: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "TRY"
        return label
    }()
    let walletStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.isUserInteractionEnabled = true
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
        textFieldCoin.delegate = self
        textFieldTRY.delegate = self
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
    // MARK: - Functions Abou View
    private func setView() {
        view.keyboardSwipeView()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = background
    }
    private func setButton() {
        gesture = UITapGestureRecognizer(target: self, action: #selector(walletTapped))
        walletStack.addGestureRecognizer(gesture)
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
        walletStack.addArrangedSubview(walletLabel)
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
            coinLabel.widthAnchor.constraint(equalToConstant: screenWidth / 4),
            coinLabel.heightAnchor.constraint(equalTo: textFieldCoin.heightAnchor),
            coinLabel.centerYAnchor.constraint(equalTo: textFieldCoin.centerYAnchor),
            coinLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            walletImage.widthAnchor.constraint(equalTo: walletImage.heightAnchor)
        ])
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
        titleLabel.layer.zPosition = -1
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
    // MARK: - Selectors and logic functions
    func cellPressed(_ currencyTapped: CurrencyPresentation) {
        presenter.cellSelected(currencyTapped)
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
        textFieldsResignFirstResponder()
        presenter.buyPressed()
    }
    @objc
    private func sellButtonPressed(_ sender: UIButton) {
        textFieldsResignFirstResponder()
        presenter.sellPressed()
    }
    @objc
    private func refresh() {
        presenter.refreshPressed()
    }
    @objc
    private func walletTapped() {
        presenter.showWallet()
    }
    @objc
    private func mainButtonPressed() {
        // 1.Resign textfield to hide keyboard
        textFieldsResignFirstResponder()
        // 2.Check data was fetch or not
        guard let selectedCurrency = selectedCurrency else {
            let loadMustEnd = Feedback.caution("Henüz data internetten yüklenemedi. Lütfen sonra tekrar deneyiniz ")
            presenter.showFeedback(loadMustEnd)
            clearTextFields()
            return }
        // 3. Decide amount
        let textfieldAmount = decideAmmount()
        let feedback = Feedback.info("Dikkat!! \(selectedCurrency.symbolFrom)'den \(textfieldAmount) adet \(selectedButton == .sell ? "satmak" : "almak") üzeresiniz.")
        let alert2 = ShowFeedBack(feedback: feedback, logic: true) { [self] _ in
            presenter.mainButtonPressed(to: selectedCurrency, for: textfieldAmount, by: selectedButton)
            clearTextFields()
        }
        present(alert2.controller, animated: true)
    }
    private func decideAmmount() -> Double {
        // condition 1 -> buy and text field have value
        if !textFieldCoin.text!.isEmpty, let amount = Double(textFieldCoin.text!), selectedButton == .buy {
            return amount
        } else if let amount = Double(textFieldCoin.placeholder!), selectedButton == .buy { // condition 2 -> buy and text field is empty
          return amount
        } else if !textFieldTRY.text!.isEmpty, let amount = Double(textFieldTRY.text!), selectedButton == .sell { // condition 3 -> sell and text field have value
            return amount
        } else if selectedButton == .sell {
            guard let amount = WalletManager.shared.myWallet.value.entities.first(where: { $0.name.lowercased() == selectedCurrency.symbolFrom.lowercased() })?.amount else {return 0 }
            return amount
        } else { fatalError("Every time we must back a value") }
    }
    private func clearTextFields() {
        textFieldCoin.text? = ""
        textFieldTRY.text? = ""
    }
}
// MARK: - Table view
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
            refreshController.endRefreshing()
            isLoading ? view.showLoadingIndicator() : view.hideLoadingIndıcator()
        case .returnCurrenciesData(let currencies):
            DispatchQueue.main.async {
                self.currencyPresantations = currencies
                self.tableView.reloadData()
            }
        case .afterSelectedButtonChange( let selectedButton):
            self.selectedButton = selectedButton
            setAfterButtonSelect(button: selectedButton)
        case .afterCoinSelected(let coin):
            setAccordingToCoin(coin)
        case .walletChange:
            setWalletStack()
        case .feedbackToView(let feedBack):
            presenter.showFeedback(feedBack)
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
            if self.buttonString.contains("SAT") && button == .buy {
                self.buttonString! = self.buttonString!.replacingOccurrences(of: "SAT", with: "AL")
            } else if self.buttonString.contains("AL") && button == .sell {
                self.buttonString! = self.buttonString!.replacingOccurrences(of: "AL", with: "SAT")
            }
        }
    }
    private func setAccordingToCoin(_ coin: CurrencyPresentation) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
            guard let self = self else { return }
            self.clearTextFields()
            self.selectedCurrency = coin
            self.labelHighValue.text = "\(coin.highPrice)"
            self.labelLowValue.text = "\(coin.lowPrice)"
            self.coinLabel.text = "\(coin.symbolFrom) Miktarı"
            if self.buttonString.split(separator: " ").count > 1 {
                self.buttonString = self.selectedButton == .buy ? "\(coin.symbolFrom) \("AL")" : "\(coin.symbolFrom) \("SAT")"
            } else {
                self.buttonString = "\(coin.symbolFrom) \(self.selectedButton == .buy ? "AL" : "SAT" )"
            }
            self.setTextFields()
        }
    }
    private func  setWalletStack() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {[weak self] in
            guard let self = self else { return }
        var myWallet = WalletManager.shared.myWallet.value
        guard let index = myWallet.entities.firstIndex(where: { $0.name.lowercased() == "try" }) else { return }
        let tryAmount = myWallet.entities[index].amount
            self.amountInWallet.text = "\( String(format: "%.2f", tryAmount)) TRY"
        guard myWallet.entities.count > 1 else { return }
        myWallet.entities.remove(at: index)
        guard let mostOwnedCoin = myWallet.entities.max(by: { $0.amount<$1.amount }) else { return }
            self.amountInWallet.text = "\(String(format: "%.2f", mostOwnedCoin.amount)) \(mostOwnedCoin.name) - \(String(format: "%.2f", tryAmount)) TRY "
            self.setTextFields()
        }
    }
    private func setTextFields() {
        guard let selectedCurrency = selectedCurrency else { return }
        guard let amount = WalletManager.shared.tryEntity?.amount else { return }
        self.textFieldTRY.placeholder = "\(String(format: "%.5f", amount)) TRY"
        let availableCoin = amount / selectedCurrency.lastPrice
        let rounded = Double((100_000 * availableCoin).rounded(.down) / 100_000)
        self.textFieldCoin.placeholder = String(format: "%.8f", rounded)
    }
}
// MARK: - View Touches
extension TradeView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldsResignFirstResponder()
    }
    private func textFieldsResignFirstResponder() {
        textFieldCoin.resignFirstResponder()
        textFieldTRY.resignFirstResponder()
    }
}
extension TradeView: UITextFieldDelegate {

}
