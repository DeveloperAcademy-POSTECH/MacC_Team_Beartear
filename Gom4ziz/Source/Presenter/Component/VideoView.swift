//
//  VideoView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/29.
//

import AVFoundation
import UIKit

final class VideoView: BaseAutoLayoutUIView {
    
    private let url: String
    private let player = AVPlayer()
    private var playerLayer: AVPlayerLayer?
    private let videoFrameView: UIView = UIView()
    private var playerObserver: Any?
    
    init(url: String) {
        self.url = url
        super.init(frame: .zero)
        self.playerLayer = setPlayerLayer(with: url)
        setVideoPlayer(with: playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = videoFrameView.bounds
    }
    
    deinit {
        guard let observer = playerObserver else { return }
        NotificationCenter.default.removeObserver(observer)
    }
}

extension VideoView {
    
    func addSubviews() {
        addSubview(videoFrameView)
    }
    
    func setUpConstraints() {
        videoFrameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoFrameView.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoFrameView.trailingAnchor.constraint(equalTo: trailingAnchor),
            videoFrameView.topAnchor.constraint(equalTo: topAnchor),
            videoFrameView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setUpUI() {
        backgroundColor = .white
    }
}

private extension VideoView {
    
    func setPlayerLayer(with url: String) -> AVPlayerLayer? {
        guard let path = Bundle.main.path(forResource: url, ofType: "mp4") else { return nil }
        print(path)
        let url = URL(fileURLWithPath: path)
        let item = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: item)
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = videoFrameView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
            self.resetPlayer()
           }
        
        return playerLayer
    }
    
    func setVideoPlayer(with playerLayer: AVPlayerLayer?) {
        guard let playerLayer = playerLayer else { return }
        videoFrameView.layer.addSublayer(playerLayer)
        player.play()
    }
}

private extension VideoView {
    
    func resetPlayer() {
        player.seek(to: CMTime.zero)
        player.play()
    }
}
