//
//  M3U8ParserViewController.swift
//  ZQPlayer
//
//  Created by zhengzeqin on 2021/6/21.
//  https://github.com/M3U8Kit/M3U8Parser

import UIKit
import M3U8Kit
class M3U8ParserViewController: UIViewController {
    
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "轻量级的M3U8解析器"
        view.backgroundColor = .white
        createUI()
        loadUrlLists()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func createUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    /// 获取解析播放列表页地址
    fileprivate func loadUrlLists() {
        let url = NSURL(string: ZQPlayerMarco.m3u8Url)
        url?.m3u_loadAsyncCompletion({ [weak self] (model, error) in
            guard let self = self, let xStreamList = model?.masterPlaylist.xStreamList else { return }
            var url: String = ""
            for index in 0...xStreamList.count {
                if let xStreamInf = xStreamList.xStreamInf(at: index) {
                    if let m3u8URL = xStreamInf.m3u8URL() {
                        print("url \(index): \(m3u8URL.absoluteString)")
                        url.append("\(index): \(m3u8URL.absoluteString) \n")
                    }
                }
            }
            DispatchQueue.main.sync {
                self.label.text = url
            }
//
        })
    }

    
}
