//
//  DevSettingViewController.swift
//  SBVideoTool
//
//  Created by 王剑鹏 on 2020/6/10.
//  Copyright © 2020 Lete. All rights reserved.
//

import UIKit
import SnapKit

/// 开发设置页面
public class DevSettingViewController: UIViewController {
    let cellIdentifier = "devTableCell"
    let optionsList : [DevOptionsModel] =
        [.init(title: "是否显示广告",
               info: "开发模式下，打开开关后会更具当前时间逻辑显示广告，关闭则不显示广告",
               key: "showAd"),
         .init(title: "是否开启沙盒储值",
               info: "开发模式下，打开开关后会走苹果的沙盒支付逻辑，关闭则使用本地车上数据完成购买",
               key: "showIAP")]
    
    
    lazy var tableView : UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(DevTableCell.self, forCellReuseIdentifier: cellIdentifier )
        tableview.estimatedRowHeight = 80
        return tableview
    }()
    
    lazy var resetButton : UIButton = { [weak self] in
        let button = UIButton(type: .custom)
        button.setTitle("重置购买", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(resetVip(sender:)), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        tableView.tableFooterView = {
            let view = UIView()
            view.addSubview(resetButton)
            view.frame = CGRect(x: 0, y: 0, width: 600, height: 70)
            resetButton.snp.makeConstraints { (make) in
                make.width.equalToSuperview().offset(-30)//.equalTo(180)
                make.height.equalToSuperview().offset(-30)
                make.center.equalToSuperview()
            }
            return view
        }()
        
    }
    
    @objc func resetVip(sender: UIButton) {
        UserManager.manager.localPaymentInfo = ["forever":false,"expiresDate":Double(0)]
        let alert = UIAlertController(title: "重置成功", message: nil, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension DevSettingViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DevTableCell
        
        cell.model = optionsList[indexPath.row]
        return cell
    }
}

struct DevOptionsModel {
    var title : String
    var info  : String
    var key   : String
}

class DevTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "title"
        return label
    }()
    lazy var infoLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "info"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var switchView : UISwitch = UISwitch()
    
    func initSubView()  {
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(infoLabel)
        labelStackView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(switchView)
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(15)
        }
        
        switchView.addTarget(self, action: #selector(switchChange(sender:)), for: .valueChanged)
    }
    
    var model : DevOptionsModel? {
        didSet {
            guard let _model = model else {
                return
            }
            titleLabel.text = _model.title
            infoLabel.text = _model.info
            switchView.isOn = UserManager.manager.localDevSettingInfo[_model.key] ?? true
        }
    }
    
    @objc func switchChange(sender:UISwitch){
        guard let _model = model else { return }
        UserManager.manager.localDevSettingInfo[_model.key] = sender.isOn
    }
}
