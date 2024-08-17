//
//  RadioService.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Combine
import AVKit

class PlayerManager: ObservableObject {
    static let shared = PlayerManager()
    var cancellables = Set<AnyCancellable>()
    var isPLaying = false
    @Published var player = AVPlayer()
    @Published var activeStation: Station?
    @Published var playerItem: AVPlayerItem?
    @Published var timeControlStatus: AVPlayer.TimeControlStatus = .paused
    
    private var session = AVAudioSession.sharedInstance()
    
    var timeObserver: Any?
    
    private init(){
        player = AVPlayer()
//        $activeStation.sink { value in
////            debugPrint(value as Any)
//        }
//        .store(in: &cancellables)
        
       
//        addPeriodicObserver()
        
    }
    
//    func addPeriodicObserver() {
//        let interval = CMTime(value: 1, timescale: 2)
//        
//        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { time in
//            debugPrint(time)
//        })
//    }
    
    func activateSession() {
        do {
            try session.setCategory(.playback, mode: .default)
        } catch {
            debugPrint(error)
        }
        
        do {
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            debugPrint(error)
        }
        
        do {
            try session.overrideOutputAudioPort(.speaker)
        } catch {
            debugPrint(error)
        }
    }
    
    func play(_ channel: Station?){
        activateSession()

        guard let channel,
              let urlString = channel.castURL,
              let url = URL(string: urlString)
        else {
            
            return
        }
        
        playerItem = AVPlayerItem(url: url)

        if player.currentItem != nil
        {
            player.replaceCurrentItem(with: playerItem)
        } else {
            player = AVPlayer(playerItem: playerItem)
        }
        
        player.play()
        activeStation = channel
        isPLaying = true
        
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] timeControlStatus in
                debugPrint(timeControlStatus)
                guard let self else { return }
                self.timeControlStatus = timeControlStatus
            }
            .store(in: &cancellables)
    }
    
    func getStatus(for station: Station) -> AVPlayer.TimeControlStatus {
        timeControlStatus
    }
    
    func pause(){
        player.pause()
        isPLaying = false
        activeStation = nil
    }
    
//    func getPlayingChannel() -> ChannelViewModel?{
//        return playingChannel
//    }
    
    func getVideoPlayer() -> AVPlayer? {
        self.player
    }
    
    func putPlayerFrame(to view: UIView) {
        view.layer.sublayers?.removeAll()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
    }
}
