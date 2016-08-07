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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewFeatureController.playbackFinished), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        
        self.player.play()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func playbackFinished() {
        self.dismissViewControllerAnimated(false, completion: nil)
        self.view.window?.rootViewController = IFBaseNavController(rootViewController: MainViewController())
    }
    
    
    private lazy var player: AVPlayer = {
        let player = AVPlayer(playerItem: self.playerItem)
        return player
    }()
    
    private lazy var playerItem: AVPlayerItem = {
        let path = NSBundle.mainBundle().pathForResource("ifanrVideo", ofType: "mp4")
        let playerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: path!))
        return playerItem
    }()
    
}