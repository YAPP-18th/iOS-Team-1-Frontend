//
//  HeroAlertController.swift
//  HeroUI
//
//  Created by Taein Kim on 2021/03/07.
//

import Foundation
import HeroCommon
import SnapKit
import UIKit

public class HeroAlertViewController: UIViewController {
    private let overLayWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    private let contentView: UIView = UIView()
    private let alertContentView: UIView = UIView()
    private let contentStackView: UIStackView = UIStackView()
    private let topButton: HeroAlertButton = HeroAlertButton()
    private let bottomButton: HeroAlertButton = HeroAlertButton()
    
    private let titleLabel: UILabel = UILabel()
    private let descLabel: UILabel = UILabel()
    
    public var positiveHandler: (() -> Void)?
    public var negativeHandler: (() -> Void)?
    
    public var buttonType: AlertButtonSetType = .okCancel
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        overLayWindow.backgroundColor = .clear
        overLayWindow.windowLevel = .normal + 25
        overLayWindow.makeKeyAndVisible()
        overLayWindow.isHidden = false
        
        setupMainLayout()
        setupViewProperties()
        updateButtonTitle()
    }
    
    private func updateButtonTitle() {
        switch buttonType {
        case .okCancel:
            topButton.title = "확인"
            bottomButton.title = "취소"
        case .yesNo:
            topButton.title = "예"
            bottomButton.title = "아니오"
        }
    }
    
    private func setupMainLayout() {
        overLayWindow.addSubview(contentView)
        contentView.addSubview(alertContentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertContentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        alertContentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descLabel)
        contentStackView.addArrangedSubview(topButton)
        contentStackView.addArrangedSubview(bottomButton)
        
        contentStackView.setCustomSpacing(8, after: titleLabel)
        contentStackView.setCustomSpacing(20, after: descLabel)
    }
    
    private func setupViewProperties() {
        contentView.backgroundColor = .clear
        contentView.alpha = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.backgroundColor = .heroGray100a
            self.contentView.alpha = 1
        })
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 0
        
        titleLabel.font = .font26PBold
        descLabel.font = .font16P
        
        titleLabel.textColor = .heroBlack100s
        descLabel.textColor = .heroGray600s
        
        titleLabel.textAlignment = .center
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        
        topButton.alertButtonType = .okay
        bottomButton.alertButtonType = .cancel
        
        topButton.addTarget(self, action: #selector(onClickPositiveButton(_:)), for: .touchUpInside)
        bottomButton.addTarget(self, action: #selector(onClickNegativeButton(_:)), for: .touchUpInside)

        alertContentView.backgroundColor = .heroWhite100s
        alertContentView.layer.shadowOpacity = 0.3
        alertContentView.layer.cornerRadius = 24
        alertContentView.layer.shadowRadius = 24
        alertContentView.layer.shadowColor = UIColor.heroBlack100s.cgColor
    }
    
    public func setTitle(title: String) {
        titleLabel.isHidden = true
        titleLabel.text = title
        titleLabel.isHidden = false
    }
    
    public func setDescription(description: String) {
        descLabel.isHidden = true
        descLabel.text = description
        descLabel.isHidden = false
    }
    
    @objc
    private func onClickPositiveButton(_ sender: UIButton) {
        positiveHandler?()
        clearAndDismiss()
    }
    
    @objc
    private func onClickNegativeButton(_ sender: UIButton) {
        negativeHandler?()
        clearAndDismiss()
    }
    
    private func clearAndDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.overLayWindow.isHidden = true
            self.dismiss(animated: false, completion: nil)
        })
    }
}
