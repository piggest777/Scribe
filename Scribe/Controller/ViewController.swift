//
//  ViewController.swift
//  Scribe
//
//  Created by Denis Rakitin on 2019-10-03.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit
import Speech
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate{

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var textView: UITextView!
    
    var audioPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "welcome", withExtension: "mp3") {
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: path)
//                        self.audioPlayer = sound
                        self.audioPlayer?.delegate = self
                        self.audioPlayer?.play()
                    } catch  {
                        print("Error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) {(result, error) in
                        if let error =  error {
                            debugPrint("Error", error.localizedDescription)
                        } else {
                            self.textView.text =  result?.bestTranscription.formattedString
                        }
                    }
                    
                }
            }
        }
    }

    @IBAction func redButtonPressed(_ sender: Any) {
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
}

