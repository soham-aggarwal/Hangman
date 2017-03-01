//
//  Hangman.swift
//  Hangman
//
//  Created by Soham Aggarwal on 2/28/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation
class Hangman {
    
    var temp = ""
    var updatedString = ""
    var prog: String = ""
    var word: String = ""
    func createWord(word: String){
        var j = Array(word.characters)
        let numElements = word.characters.count
        for i in 0...(numElements - 1){
            if (j[i] == " "){
                prog.append(" ")
                continue
            }
            prog.append("_")
        }
    }
    
    func findInstances(somePhrase: String, inputString: String) -> [Int] {
        temp = somePhrase.trimmingCharacters(in: .whitespaces)
        print(temp)
        var g = Array(temp.characters)
        var instances = [Int]()
        let numElements = g.count - 1
        for i in 0...numElements {
            if (inputString == String(g[i])){
                instances.append(i)
            }
        }
        return instances
    }
    func checkLetterAndReplace(input: String, randomPhrase: String, updatedGuesses: String) -> Bool {
        if (randomPhrase.contains(input)){
            let instance = findInstances(somePhrase: randomPhrase, inputString: input)
            updatedString = replaceUnderscores(instances: instance, input: input, retVal: updatedGuesses)
            return true
        } else{
            
            return false
        }
    }
    
    func replaceUnderscores(instances: [Int], input: String, retVal: String) -> String{
        
        let inputChar = Array(input.characters)
        let charIn: Character = inputChar[0]
        var integer = Array(retVal.characters)
        for i in 0...(instances.count - 1) {
            integer[instances[i]] = charIn
        }
        print(instances[0])
        var finalString = ""
        print(retVal.characters.count)
        print(integer.count)
        for i in 0...(retVal.characters.count - 1){
            finalString.append(integer[i])
        }
        return finalString
    }
    
    func checkWin(finalString: String, inputPhrase: String) -> Bool{
        if (finalString == inputPhrase) {
            return true
        }
        return false
    }
    func alreadyGuessed(input: String, guesses: String) -> Bool{
        if (guesses.contains(input)){
            return true
        }
        return false
    }
}
