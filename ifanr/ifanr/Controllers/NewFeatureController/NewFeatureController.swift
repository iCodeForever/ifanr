//
//  NewFeatureController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/22.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import AVFoundation

class NewFeatureController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 监听播放完成
        NotificationCenter.default.addObserver(self, selector: #selector(NewFeatureController.playbackFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        
        self.player.play()
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func playbackFinished() {
        self.dismiss(animated: false, completion: nil)
        self.view.window?.rootViewController = IFBaseNavController(rootViewController: MainViewController())
    }
    
    
    fileprivate lazy var player: AVPlayer = {
        let player = AVPlayer(playerItem: self.playerItem)
        return player
    }()
    
    fileprivate lazy var playerItem: AVPlayerItem = {
        let path = Bundle.main.path(forResource: "ifanrVideo", ofType: "mp4")
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path!))
        return playerItem
    }()
    
}
