//
//  ViewController.swift
//  MusicPlayer_iOS
//
//  Created by Lobler Ádám on 2017. 10. 27..
//  Copyright © 2017. Lobler Ádám. All rights reserved.
//

import UIKit
import MediaPlayer

@IBDesignable class MainViewController: UIViewController {
    private var MusicDataManager: musicDataManager?
    
    @IBOutlet weak var musicControlButtonsOutlet: UIView!
    @IBOutlet weak var volumeViewOutlet: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var musicLibraryButton: UIButton!
  
    //MARK: MUSIC TITLE
    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var artistAndAlbumLabel: UILabel!
    //MARK: VOLUME BUTTON
    @IBOutlet weak var volumeButton: volumeButton!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumePercentage: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet var VolumeButtonGestureRecognizer: UIPanGestureRecognizer!
    
    @IBAction func MusicLibraryControllerDidCancel(unwindSegue: UIStoryboardSegue) {
        let viewController = unwindSegue.source as! MusicLibraryController
        MplayerController.musicPlayerController.nowPlayingItem = viewController.currentSong
        updateCurrentItemData()
    }
    
    @IBAction func VolumeButtonGestureAction(_ sender: UIPanGestureRecognizer) {
        let xTranslation = sender.translation(in: sender.view).x
        let tolerance: CGFloat = 5
        if abs(xTranslation) >= tolerance {
            let newValue = volumeSlider.value + (Float(xTranslation / tolerance))/40
            volumeSlider.setValue(newValue, animated: true)
            // SET UI Elements
            volumePercentage.text = String(Int(volumeSlider.value*100))
            let backgroundcolor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: CGFloat(volumeSlider.value));
            volumeButton.borderColor = backgroundcolor;
            backgroundImage.layer.borderColor = backgroundcolor.cgColor
            if(volumeSlider.value<=0.1){
                volumeButton.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
            }
            sender.setTranslation(.zero, in: sender.view)
        }
    }
    
    //MARK: MUSIC PLAYER
    @IBOutlet weak var playButtonOutlet: UIButton!
    var MplayerController = musicPlayerControl()
    var MvolumeView = MPVolumeView()
    var isPlaying:Bool = false
    var emptyLibrary:Bool = true
    
    @IBAction func playButtonAction(_ sender: UIButton) {
       playsong()
    }
    func playsong(){
        if isPlaying == false{
            MplayerController.play()
            let pauseimage = #imageLiteral(resourceName: "pause_button")
            playButtonOutlet.setImage(pauseimage, for: .normal)
            backgroundImage.image = MplayerController.albumartwork
            musicTitleLabel.text = MplayerController.musicTitle
            isPlaying = true
            
        }
        else {
            MplayerController.pause()
            let playimage = #imageLiteral(resourceName: "play_button")
            playButtonOutlet.setImage(playimage, for: .normal)
            isPlaying = false
        }
        //updateCurrentItemData()

    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        MplayerController.playNext()
        updatelabel()
    }
    @IBAction func previousButtonAction(_ sender: UIButton) {
        MplayerController.playPrevious()
        updatelabel()
    }
    @IBOutlet weak var CurrentTimeLabel: UILabel!
    @IBOutlet weak var FullTimeLabel: UILabel!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var songSlider: UISlider!
    @IBAction func songSliderChanged(_ sender: UISlider) {
        MplayerController.musicPlayerController.currentPlaybackTime = TimeInterval(songSlider.value)
        
    }
    var currentTime = Double()
    var fullTime = Double()

    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        if hours == 0 {
            return String(format: "%02d:%02d", minutes, seconds)}
        else{
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)}
    }
    
    @objc func updatelabel(){
        //let sec = String(MplayerController.musicPlayerController.currentPlaybackTime)
        if (MplayerController.musicPlayerController.currentPlaybackTime > 0) {
            CurrentTimeLabel.text =  stringFromTimeInterval(interval: MplayerController.musicPlayerController.currentPlaybackTime)}
        else{CurrentTimeLabel.text = "00:00"}

        //FULL TIME OF THE SONG
        if (MplayerController.musicPlayerController.nowPlayingItem != nil){
            FullTimeLabel.text = stringFromTimeInterval(interval: (MplayerController.musicPlayerController.nowPlayingItem?.playbackDuration)!)
        }
    }
    
    @objc func updateSlider(){
        if (MplayerController.musicPlayerController.nowPlayingItem != nil){
        fullTime = Double((MplayerController.musicPlayerController.nowPlayingItem?.playbackDuration)!)
        songSlider.maximumValue = Float(fullTime)
        let time = String(MplayerController.musicPlayerController.currentPlaybackTime)
        let currentTime = Double(time)!
            songSlider.setValue(Float(currentTime), animated: true)}
    }
    
    func parallax (toView view:UIView, magnitude:Float){
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let EffectGroup = UIMotionEffectGroup();
        EffectGroup.motionEffects = [xMotion, yMotion]
        view.addMotionEffect(EffectGroup);
    }
    
    func addParallaxtoAllView(){
        parallax(toView: backImage, magnitude: 100)
        parallax(toView: backgroundImage, magnitude: -20)
        parallax(toView: musicTitleLabel, magnitude: -20)
        parallax(toView: artistAndAlbumLabel, magnitude: -20)
        parallax(toView: musicControlButtonsOutlet, magnitude: -20)
        parallax(toView: volumeViewOutlet, magnitude: -20)
        parallax(toView: musicLibraryButton, magnitude: -20)
    }
    
    func addBlurToBackground(){
        // 1
        let darkBlur1 = UIBlurEffect(style: UIBlurEffectStyle.dark)
        // 2
        let blurView1 = UIVisualEffectView(effect: darkBlur1)
        blurView1.frame = backImage.bounds
        parallax(toView: blurView1, magnitude: -20)
        // 3
        backImage.addSubview(blurView1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MusicDataManager = (UIApplication.shared.delegate as? AppDelegate)?.MusicDataManager
        
        //SET UP UI ELEMENTS
        backgroundImage.layer.cornerRadius = 50
        backgroundImage.layer.borderWidth = 3
        backgroundImage.layer.borderColor = UIColor.white.cgColor
        backgroundImage.clipsToBounds = true
        addBlurToBackground()
        addParallaxtoAllView()
        
        //NOTICENTER
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleMusicPlayerManagerDidUpdateState),
                                               name: musicPlayerControl.didUpdateState,
                                               object: nil)
        updateCurrentItemData()
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MainViewController.updatelabel), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MainViewController.updateSlider), userInfo: nil, repeats: true)
        hiddenView.addSubview(MvolumeView)
        MvolumeView.showsRouteButton = false
        for view in MvolumeView.subviews {
            if let volsl = view as? UISlider {
                volumeSlider = volsl
                // SET VOLUME PERCENTAGE TO CURRENT VOLUME
                volumeSlider.setValue(AVAudioSession.sharedInstance().outputVolume, animated: true)
                volumePercentage.text = String(Int(volumeSlider.value*100))
                break
            }
        }
    }
    
    func updateCurrentItemData() {
        if MplayerController.musicPlayerController.nowPlayingItem != nil{
        if let artwork: MPMediaItemArtwork = MplayerController.musicPlayerController.nowPlayingItem?.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork{
            MplayerController.albumartwork = artwork.image(at: CGSize(width: 200, height: 200))!}
        backgroundImage.image = MplayerController.albumartwork
        backImage.image = MplayerController.albumartwork
        let artist = (MplayerController.musicPlayerController.nowPlayingItem?.artist)!
        let songTitle = (MplayerController.musicPlayerController.nowPlayingItem?.title)!
        let album = (MplayerController.musicPlayerController.nowPlayingItem?.albumTitle)!
        MplayerController.musicTitle = "\(songTitle)"
        musicTitleLabel.text = songTitle
        artistAndAlbumLabel.text = "\(artist) - \(album)"
        }else {print("No music playing!")}
    }
    
    @objc func handleMusicPlayerManagerDidUpdateState() {
        DispatchQueue.main.async {
            self.updateCurrentItemData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

