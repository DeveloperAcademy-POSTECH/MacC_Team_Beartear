//
//  VideoView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/29.
//

import AVFoundation
import UIKit

final class VideoView: UIView {
    
    private let url: String
    private let player = AVPlayer()
    private var playerLayer: AVPlayerLayer?
    private var playerObserver: Any?
    
    init(url: String) {
        self.url = url
        super.init(frame: .zero)
        self.playerLayer = setPlayerLayer(with: url)
        setVideoPlayer(with: playerLayer)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }

    func startVideo() {
        player.play()
    }

    func stopVideo() {
        player.pause()
    }
    
    deinit {
        guard let observer = playerObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
}

private extension VideoView {
    
    func setUpUI() {
        backgroundColor = .white
    }
    
    func setPlayerLayer(with url: String) -> AVPlayerLayer? {
        guard let path = Bundle.main.path(forResource: url, ofType: "mp4") else { return nil }
        print(path)
        let url = URL(fileURLWithPath: path)
        let item = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: item)
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = bounds
        playerLayer.videoGravity = .resizeAspect
        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { [weak self] _ in
            self?.resetPlayer()
           }
        
        return playerLayer
    }
    
    func setVideoPlayer(with playerLayer: AVPlayerLayer?) {
        guard let playerLayer = playerLayer else { return }
        layer.addSublayer(playerLayer)
    }
}

private extension VideoView {
    
    func resetPlayer() {
        player.seek(to: CMTime.zero)
        player.play()
    }
}
