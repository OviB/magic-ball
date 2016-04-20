//
//  MainVC.swift
//  Magic8Ball
//
//  Created by Ovidiu Bortas on 4/19/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var answerLabel: UILabel!
    
    var answers = [
        "It is certain",
        "It is decidedly so",
        "Without a doubt",
        "Yes, definitely",
        "You may rely on it",
        "As I see it, yes",
        "Most likely",
        "Outlook good",
        "Yes",
        "Signs point to yes",
        "Reply hazy try again",
        "Ask again later",
        "Better not tell you now",
        "Cannot predict now",
        "Concentrate and ask again",
        "Don't count on it",
        "My reply is no",
        "My sources say no",
        "Outlook not so good",
        "Very doubtful"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.text = "Ask a Queston!"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func answerTapped(sender: AnyObject) {
        
        let random = Int(arc4random_uniform(UInt32(answers.count)))
        
        answerLabel.text = answers[random]
        
        do {
            try playSound("Shakesound", fileExtension: "wav")
        } catch {
            return
        }
    }
    
    func playSound(fileName: String, fileExtension: String) throws {
        
        let dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(dispatchQueue, { let mainBundle = NSBundle.mainBundle()
            
            let filePath = mainBundle.pathForResource("\(fileName)", ofType:"\(fileExtension)")
            
            if let path = filePath{
                let fileData = NSData(contentsOfFile: path)
                
                do {
                    /* Start the audio player */
                    self.audioPlayer = try AVAudioPlayer(data: fileData!)
                    
                    guard let player : AVAudioPlayer? = self.audioPlayer else {
                        return
                    }
                    
                    /* Set the delegate and start playing */
                    player!.delegate = self
                    if player!.prepareToPlay() && player!.play() {
                        /* Successfully started playing */
                    } else {
                        /* Failed to play */
                    }
                    
                } catch {
                    //self.audioPlayer = nil
                    return
                }
                
            }
            
        })
        
    }
}



