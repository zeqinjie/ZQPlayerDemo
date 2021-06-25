//
//  ZFPlayerViewController.swift
//  ZQPlayer
//
//  Created by zhengzeqin on 2021/6/21.
//

import UIKit
import ZFPlayer
import SnapKit
class ZFPlayerViewController: UIViewController {
    
    struct Marco {
        static let videosP = ["360P","480P", "720P"]
    }
    
    fileprivate lazy var assetURLs: [URL]? = {
        guard let m3u8_360p_url: URL = URL(string: ZQPlayerMarco.m3u8_360p) else { return nil }
        guard let m3u8_480p_url: URL = URL(string: ZQPlayerMarco.m3u8_480p) else { return nil }
        guard let m3u8_720p_url: URL = URL(string: ZQPlayerMarco.m3u8_720p) else { return nil }
        return [
            m3u8_360p_url,
            m3u8_480p_url,
            m3u8_720p_url
        ]
    }()
    
    fileprivate lazy var controlView: ZFPlayerControlView = {
        let controlView = ZFPlayerControlView()
        controlView.fastViewAnimated = true
        controlView.autoHiddenTimeInterval = 5
        controlView.autoFadeTimeInterval = 0.5
        controlView.prepareShowLoading = true
        controlView.prepareShowControlView = false
        controlView.fastProgressView.isHidden  = true
        return controlView
    }()
    
    
    fileprivate var videoPlayIndex: Int = 0
    /// 下一部
    fileprivate lazy var nextBtn: UIButton = {
        let btn: UIButton = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside)
        btn.setTitle("Next", for: .normal)
        btn.backgroundColor = .red
        btn.tag = 1
        return btn
    }()
    
    /// 切换清晰度
    fileprivate lazy var changeBtn: UIButton = {
        let btn: UIButton = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside)
        btn.setTitle(Marco.videosP.first ?? "", for: .normal)
        btn.backgroundColor = .red
        btn.tag = 2
        return btn
    }()
    
    fileprivate lazy var containerView:UIImageView = {
        let containerView = UIImageView()
        containerView.setImageWithURLString(ZQPlayerMarco.kVideoCover, placeholder: ZFUtilities.image(with: .black, size: CGSize(width: 1, height: 1)))
        return containerView
    }()
    
    fileprivate var player: ZFPlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "ZFPlayer"
        // Do any additional setup after loading the view.
        createUI()
        setupPlayer()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    // MARK: - Action
    @objc func btnAction(_ btn: UIButton) {
        switch btn.tag {
        case 1: // 下一步
            if self.player?.isLastAssetURL != nil {
                self.player?.playTheNext()
            } else {
                self.player?.playTheIndex(0)
            }
            self.controlView.showTitle("视频标题: \(self.player?.currentPlayIndex ?? 0)", coverURLString: ZQPlayerMarco.kVideoCover, fullScreenMode: .automatic)
        default:
            self.videoPlayIndex += 1
            self.player?.seek(toTime: self.player?.currentPlayerManager.currentTime ?? 0, completionHandler: { success in
                print("seekToTime = \(success ? "success" : "fail")")
            })
            self.changeBtn.setTitle(Marco.videosP[self.videoPlayIndex % 3], for: .normal)
            break
        }
    }
}

extension ZFPlayerViewController {
    fileprivate func createUI() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(containerView.snp.width).multipliedBy(9.0/16.0)
            make.center.equalToSuperview()
        }
        
        controlView.addSubview(nextBtn)
        controlView.addSubview(changeBtn)
        nextBtn.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.right.equalToSuperview()
            make.bottom.equalTo(-50)
        }
        
        changeBtn.snp.makeConstraints { make in
            make.size.equalTo(nextBtn)
            make.centerY.equalTo(nextBtn)
            make.right.equalTo(nextBtn.snp.left).offset(-3)
        }
    }
    
    
    fileprivate func setupPlayer() {
        let playerManager: ZFAVPlayerManager = ZFAVPlayerManager()
        playerManager.shouldAutoPlay = true
        self.player = ZFPlayerController(playerManager: playerManager, containerView: containerView)
        self.player?.controlView = self.controlView
        self.player?.pauseWhenAppResignActive = false
        self.player?.playerDidToEnd = { [weak self] asset in
            print("playing = \(asset)")
        }
        self.player?.assetURLs = self.assetURLs
        self.player?.playTheIndex(0)
        self.controlView.showTitle("demo", coverURLString: ZQPlayerMarco.kVideoCover, fullScreenMode: .automatic)
    }
}


//class ZFCustomControlView: UIView, ZFPlayerMediaControl {
//}
