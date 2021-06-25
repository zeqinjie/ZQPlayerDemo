//
//  ZQPlayerHeader.swift
//  ZQPlayer
//
//  Created by zhengzeqin on 2021/6/21.
//

import Foundation


enum ZQPlayerHeaderCellType {
    /// 基于 ZFPlayer 播放
    case zfPlayer
    /// 基于 ZFPlayer 播放 自定义
    case zfPlayerCustom
    /// SJVideoPlayer
    case sjVideoPlayer
    /// M3U8Kit 解析库
    case m3u8Parser
}


struct ZQPlayerMarco {
    static let m3u8Url: String = "https://video.591.com.tw/debug/target/hls/house/5s/master.m3u8"
    static let kVideoCover: String = "https://video.591.com.tw/debug/target/hls/house/59113.jpg"
    static let m3u8_360p: String = "https://video.591.com.tw/debug/target/hls/house/5s/stream_0.m3u8"
    static let m3u8_480p: String = "https://video.591.com.tw/debug/target/hls/house/5s/stream_1.m3u8"
    static let m3u8_720p: String = "https://video.591.com.tw/debug/target/hls/house/5s/stream_2.m3u8"
}
