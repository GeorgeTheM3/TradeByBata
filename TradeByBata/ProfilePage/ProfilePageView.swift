//
//  ProfilePageView.swift
//  TradeByBata
//
//  Created by Георгий Матченко on 21.03.2023.
//

import UIKit

class ProfilePageView: UITableViewController {
    
    private var viewModel: ProfilePageViewModel
    
    private let heightScreen = UIScreen.main.bounds.height
    
    private weak var passInfoToProfileCell: PassInfoToProfileCellProtocol?
    private weak var passInfoToHeader: PassSettingsForHeaderProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        tableView.backgroundColor = .systemBackgroundColor
    }
    
    init(viewModel: ProfilePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        createCustomNavigationBar(title: "Profile")
    }
    
    @objc func pressButton() {
        print("press")
    }
    
    private func setupTableView() {
        tableView.register(ProfileCustomCell.self, forCellReuseIdentifier: ProfileCustomCell.reuseId)
        tableView.separatorStyle = .none
        tableView.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: ProfileHeader.reuseId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCustomCell.reuseId, for: indexPath) as? ProfileCustomCell {
            passInfoToProfileCell = cell
            cell.backgroundColor = .systemBackgroundColor
            switch indexPath.row {
            case 0:
                let image = UIImage(systemName: "creditcard")
                passInfoToProfileCell?.passProduct(image: image, title: "Trade store", hideRightImage: false, hideMoneyLabel: true, money: nil)
                return cell
            case 1:
                let image = UIImage(systemName: "creditcard")
                passInfoToProfileCell?.passProduct(image: image, title: "Payment methode", hideRightImage: false, hideMoneyLabel: true, money: nil)
                return cell
            case 2:
                let image = UIImage(systemName: "creditcard")
                let userMoney = viewModel.getUserMoney()
                passInfoToProfileCell?.passProduct(image: image, title: "Balance", hideRightImage: true, hideMoneyLabel: false, money:
                                                    userMoney)
                return cell
            case 3:
                let image = UIImage(systemName: "creditcard")
                passInfoToProfileCell?.passProduct(image: image, title: "Trade history", hideRightImage: false, hideMoneyLabel: true, money: nil)
                return cell
            case 4:
                let image = UIImage(systemName: "arrow.triangle.2.circlepath")
                passInfoToProfileCell?.passProduct(image: image, title: "Restore Purchase", hideRightImage: false, hideMoneyLabel: true, money: nil)
                return cell
            case 5:
                let image =  UIImage(systemName: "questionmark.circle")
                passInfoToProfileCell?.passProduct(image: image, title: "Help", hideRightImage: true, hideMoneyLabel: true, money: nil)
                return cell
            case 6:
                let image =  UIImage(systemName: "rectangle.portrait.and.arrow.forward")
                passInfoToProfileCell?.passProduct(image: image, title: "Log out", hideRightImage: true, hideMoneyLabel: true, money: nil)
                return cell
            default:
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightScreen * 0.075
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 6 {
            dismiss(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeader.reuseId) as? ProfileHeader {
            let userName = viewModel.getUserFullName()
            passInfoToHeader = header
            if let imageData = viewModel.getUserPhoto() {
                guard let photo = UIImage(data: imageData) else { return nil }
                passInfoToHeader?.headerSettings(userName, photo)
            } else {
                let defaultPhoto = UIImage(named: "default-user")
                passInfoToHeader?.headerSettings(userName, defaultPhoto)
            }
            return header
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightScreen * 0.21
    }
    
}
