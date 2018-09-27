//
//  musicPlayerController.swift
//  MusicPlayer_iOS
//
//  Created by Lobler Ádám on 2017. 11. 17..
//  Copyright © 2017. Lobler Ádám. All rights reserved.
//

import UIKit
import MediaPlayer

@objcMembers
class musicPlayerControl: NSObject {
    
    static let didUpdateState = NSNotification.Name("didUpdateState")
    private var MusicDataManager: musicDataManager?

    let predicate = MPMediaPropertyPredicate()
    var isPlaying:Bool = false
    
    // SONG DETAILS
    var albumartwork = UIImage()
    var musicTitle = String()
    var artist = String()
    var songTitle = String()
    let musicPlayerController = MPMusicPlayerController.systemMusicPlayer
    
    override init() {
        super.init()
        musicPlayerController.beginGeneratingPlaybackNotifications()
        MusicDataManager = (UIApplication.shared.delegate as? AppDelegate)?.MusicDataManager
        
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleMusicPlayerControllerNowPlayingItemDidChange),
                                       name: .MPMusicPlayerControllerNowPlayingItemDidChange,
                                       object: musicPlayerController)
        
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleMusicPlayerControllerPlaybackStateDidChange),
                                       name: .MPMusicPlayerControllerPlaybackStateDidChange,
                                       object: musicPlayerController)
     
        musicPlayerController.setQueue(with: (MusicDataManager?.query)!)
        
    }
    
    deinit {
       
        musicPlayerController.endGeneratingPlaybackNotifications()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(self,
                                          name: .MPMusicPlayerControllerNowPlayingItemDidChange,
                                          object: musicPlayerController)
        notificationCenter.removeObserver(self,
                                          name: .MPMusicPlayerControllerPlaybackStateDidChange,
                                          object: musicPlayerController)
    }
    
    
    func pause(){
        musicPlayerController.pause()
    }
    func play(){
        musicPlayerController.play()
    }
    
    func playNext(){
        musicPlayerController.skipToNextItem()
        
    }
    func playPrevious(){
        musicPlayerController.skipToPreviousItem()
    }
    
    func handleMusicPlayerControllerNowPlayingItemDidChange() {
        NotificationCenter.default.post(name: musicPlayerControl.didUpdateState, object: nil)
    }
    
    func handleMusicPlayerControllerPlaybackStateDidChange() {
        NotificationCenter.default.post(name: musicPlayerControl.didUpdateState, object: nil)
    }

}
