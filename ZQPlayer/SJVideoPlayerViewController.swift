//
//  SJVideoPlayerViewController.swift
//  ZQPlayer
//
//  Created by zhengzeqin on 2021/6/23.
//

import UIKit
import SJVideoPlayer
import SnapKit

class SJVideoPlayerViewController: UIViewController {
    
    fileprivate var player: SJVideoPlayer?
    fileprivate let playerContainerView: UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SJVideoPlayer"
        self.view.backgroundColor = .white
        setupViews()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    fileprivate func setupViews() {
        player = SJVideoPlayer()
        view.addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(playerContainerView.snp.width).multipliedBy(9.0/16.0)
            make.center.equalToSuperview()
        }
        
        guard let player = self.player else { return }
        playerContainerView.addSubview(player.view)
        player.view.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        player.controlLayerAppearObserver.appearStateDidChangeExeBlock = { mgr in
            player.promptPopupController.bottomMargin = mgr.isAppeared ? player.defaultEdgeControlLayer.bottomContainerView.bounds.size.height : 16
        }
    }
    
    fileprivate func setupData() {
        var assets: [SJVideoPlayerURLAsset] = []
        if let url = URL(string: ZQPlayerMarco.m3u8_360p), let asset = SJVideoPlayerURLAsset(url: url) {
            asset.definition_fullName = "流畅 360P"
            asset.definition_lastName = "360P"
            assets.append(asset)
        }
        
        if let url = URL(string: ZQPlayerMarco.m3u8_480p), let asset = SJVideoPlayerURLAsset(url: url) {
            asset.definition_fullName = "清晰 480p"
            asset.definition_lastName = "480p"
            assets.append(asset)
        }
        
        if let url = URL(string: ZQPlayerMarco.m3u8_720p), let asset = SJVideoPlayerURLAsset(url: url) {
            asset.definition_fullName = "高清 720p"
            asset.definition_lastName = "720p"
            assets.append(asset)
        }
        
        player?.definitionURLAssets = assets
        player?.urlAsset = assets.first
    }
}
