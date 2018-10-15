//
//  MusicPlayer_iOSTests.swift
//  MusicPlayer_iOSTests
//
//  Created by Lobler Ádám on 2018. 09. 28..
//  Copyright © 2018. Lobler Ádám. All rights reserved.
//

import XCTest
import MediaPlayer
@testable import MusicPlayer_iOS

class MusicPlayer_iOSTests: XCTestCase {
    var TestMainView = MainViewController();
    var TestMplayerController = musicPlayerControl();
    var TestData = musicDataManager();
    
    override func setUp() {
        super.setUp();
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testPlaySongWithController() {
//        TestMplayerController.play();
//    }
    
    func testPauseSongWithController() {
        TestMplayerController.pause();
    }
    
    func testPlayNextSongWithController() {
        TestMplayerController.playNext();
    }
    
    func testPlayPreviousSongWithController() {
        TestMplayerController.playPrevious();
    }

}


//MPMusicPlayerController.systemMusicPlayer.play();
//TestMainView.playsong();


