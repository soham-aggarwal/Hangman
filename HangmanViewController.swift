//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var randomString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        randomString = phrase
        print(phrase)
        hangman.createWord(word: randomString)
        wordHolder.text = hangman.prog
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    var hangman = Hangman()
    
    var imageIndex = 1
    
    @IBOutlet weak var wordHolder: UILabel!
    
    @IBOutlet weak var hangmanImageView: UIImageView!
    
    @IBOutlet weak var inputString: UITextField!
    
    @IBOutlet weak var wrong: UILabel!
    
    @IBAction func guessButtonWasPressed(_ sender: UIButton) {
        var inputPhrase: String?
        inputPhrase = inputString.text
        let letters = CharacterSet.letters
        
        if ((inputPhrase?.characters.count)! > 1){
            let alert = UIAlertController(title: "WRONG CHARACTER LENGTH", message: "ENTER ONLY SINGLE CHARACTER!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "TRY AGAIN??", style: UIAlertActionStyle.destructive, handler: { action in
                //create new game
            }))
            self.present(alert, animated: false, completion: nil)
        } else if (inputPhrase == nil){
            let alert = UIAlertController(title: "Come on, man", message: "Like make a guess atleast!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "TRY AGAIN??", style: UIAlertActionStyle.destructive, handler: { action in
                //DOES NOTHING
            }))
            self.present(alert, animated: false, completion: nil)
        } else if (!letters.contains(UnicodeScalar(inputPhrase!)!)){
            let alert = UIAlertController(title: "WRONG CHARACTER TYPE", message: "ENTER ONLY ALPHABET!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "TRY AGAIN??", style: UIAlertActionStyle.destructive, handler: { action in
                //create new game
            }))
            self.present(alert, animated: false, completion: nil)
        }
        
        else {
        inputPhrase = inputPhrase?.uppercased()
        let winner = hangman.checkWin(finalString: hangman.updatedString, inputPhrase: randomString)
        if inputPhrase != nil {
            let wrongGuess: String = wrong.text!
            if (!hangman.alreadyGuessed(input: inputPhrase!, guesses: wrongGuess)){
                if (hangman.checkLetterAndReplace(input: inputPhrase!, randomPhrase: randomString, updatedGuesses: wordHolder.text!)){
                    wordHolder.text = hangman.updatedString
                    
                } else if (imageIndex < 7 && winner){
                    let alert = UIAlertController(title: "Alert", message: "YOU ARE WINNER!!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "TRY AGAIN??", style: UIAlertActionStyle.destructive, handler: { action in
                        //create new game
                        self.hangman = Hangman()
                    }))
                    self.present(alert, animated: false, completion: nil)
                    
                }
                
                else {
                    imageIndex += 1
                    if (imageIndex >= 7 && !winner) {
                        let alert = UIAlertController(title: "Alert", message: "YOU ARE LOSER!!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "TRY AGAIN??", style: UIAlertActionStyle.destructive, handler: { action in
                            //create new game
                            
                        }))
                        self.present(alert, animated: false, completion: nil)
                    }
                    let imageName = "hangman" + String(imageIndex)
                    hangmanImageView.image = UIImage(named: imageName)
                    //if (imageindex )
                    wrong.text = wrong.text! + " " + inputPhrase!
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a letter to guess", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.destructive, handler: nil))
        }
        
    }
    }
    

}
