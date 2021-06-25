//
//  ViewController.swift
//  ZQPlayer
//
//  Created by zhengzeqin on 2021/6/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Private Property
    fileprivate lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        return $0
    } (UITableView())
    
    /// 功能类型数组
    fileprivate let funcTypeArr: [ZQPlayerHeaderCellType] = [
        .zfPlayer,
        .sjVideoPlayer,
        .m3u8Parser
    ]
    
    fileprivate let cellId = "CELLID"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }


}

// MARK: - Private Method
extension ViewController {
    fileprivate func initUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.funcTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: self.cellId)
        }
        
        var cellTitle = "none"
        let funcType = self.funcTypeArr[indexPath.item]
        switch funcType {
        case .zfPlayer:
            cellTitle = "ZFPlayerViewController"
        case .zfPlayerCustom:
            cellTitle = "ZFPlayerCustomViewController"
        case .sjVideoPlayer:
            cellTitle = "SJVideoPlayerViewController"
        case .m3u8Parser:
            cellTitle = "M3U8ParserViewController"
        }
        cell?.textLabel?.text = cellTitle
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController?
        let funcType = self.funcTypeArr[indexPath.item]
        switch funcType {
        case .zfPlayer:
            vc = ZFPlayerViewController()
        case .zfPlayerCustom:
            vc = ZFPlayerCustomViewController()
        case .sjVideoPlayer:
            vc = SJVideoPlayerViewController()
        case .m3u8Parser:
            vc = M3U8ParserViewController()
        }
        guard let _vc = vc else { return }
        self.navigationController?.pushViewController(_vc, animated: true)
    }
}
