//
//  musicDataManager.swift
//  MusicPlayer_iOS
//
//  Created by Lobler Ádám on 2017. 11. 18..
//  Copyright © 2017. Lobler Ádám. All rights reserved.
//

import UIKit
import MediaPlayer

class musicDataManager {
    var songs: [MPMediaItem]
    var query = MPMediaQuery.songs()
    
    init() {
        let musicPlayerController = MPMusicPlayerController.systemMusicPlayer
        musicPlayerController.setQueue(with: (query))
        if query.items != nil{
        songs = (Array(query.items!) as [MPMediaItem])
        
        for ind in songs{
            print(ind.title!)
        }
           
            
        }else {self.songs = [MPMediaItem.init()]}
        
    }
        
        
    
}
