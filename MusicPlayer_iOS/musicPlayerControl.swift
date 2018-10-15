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
    let systemMusicPlayerController = MPMusicPlayerController.systemMusicPlayer
    
    override init() {
        super.init()
        systemMusicPlayerController.beginGeneratingPlaybackNotifications()
        MusicDataManager = (UIApplication.shared.delegate as? AppDelegate)?.MusicDataManager
        
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleMusicPlayerControllerNowPlayingItemDidChange),
                                       name: .MPMusicPlayerControllerNowPlayingItemDidChange,
                                       object: systemMusicPlayerController)
        
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleMusicPlayerControllerPlaybackStateDidChange),
                                       name: .MPMusicPlayerControllerPlaybackStateDidChange,
                                       object: systemMusicPlayerController)
        
        systemMusicPlayerController.setQueue(with: (MusicDataManager?.query)!)
        
    }
    
    deinit {
        systemMusicPlayerController.endGeneratingPlaybackNotifications()
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self,
                                          name: .MPMusicPlayerControllerNowPlayingItemDidChange,
                                          object: systemMusicPlayerController)
        notificationCenter.removeObserver(self,
                                          name: .MPMusicPlayerControllerPlaybackStateDidChange,
                                          object: systemMusicPlayerController)
    }
    
    func pause(){
        systemMusicPlayerController.pause()
    }
    func play(){
        if (systemMusicPlayerController.nowPlayingItem != nil)
        {
        systemMusicPlayerController.play()
        artist = (systemMusicPlayerController.nowPlayingItem?.artist)!;
        
        if let artwork: MPMediaItemArtwork = systemMusicPlayerController.nowPlayingItem?.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork{
            albumartwork = artwork.image(at: CGSize(width: 200, height: 200))!}
        musicTitle = (systemMusicPlayerController.nowPlayingItem?.title)!;
        artist = (systemMusicPlayerController.nowPlayingItem?.artist)!;
        //var songTitle = String()
        }
    }
    
    func playNext(){
        systemMusicPlayerController.skipToNextItem()
        
    }
    func playPrevious(){
        systemMusicPlayerController.skipToPreviousItem()
    }
    
    func handleMusicPlayerControllerNowPlayingItemDidChange() {
        NotificationCenter.default.post(name: musicPlayerControl.didUpdateState, object: nil)
    }
    
    func handleMusicPlayerControllerPlaybackStateDidChange() {
        NotificationCenter.default.post(name: musicPlayerControl.didUpdateState, object: nil)
    }
    
}
