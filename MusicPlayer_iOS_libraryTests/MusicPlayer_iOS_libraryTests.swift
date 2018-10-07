//
//  MusicPlayer_iOS_libraryTests.swift
//  MusicPlayer_iOS_libraryTests
//
//  Created by Lobler Ádám on 2018. 10. 07..
//  Copyright © 2018. Lobler Ádám. All rights reserved.
//

import XCTest
import MediaPlayer
@testable import MusicPlayer_iOS

class MusicPlayer_iOS_libraryTests: XCTestCase {
    var testMusicLibrary: MusicLibraryController!;


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        testMusicLibrary = MusicLibraryController();
        let _ = testMusicLibrary.view;
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


}
