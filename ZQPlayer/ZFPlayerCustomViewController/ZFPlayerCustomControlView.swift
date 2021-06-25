//
//  ZFPlayerCustomControlView.swift
//  ZQPlayer
//
//  Created by zhengzeqin on 2021/6/23.
//

import UIKit
import ZFPlayer

class ZFPlayerCustomControlView: UIView, ZFPlayerMediaControl {
    var player: ZFPlayerController?
    
    /// 底部工具栏
    fileprivate let bottomToolView: UIView = UIView()
    /// 顶部工具栏
    fileprivate let topToolView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
