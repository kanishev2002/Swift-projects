//
//  ViewController.swift
//  Hangman
//
//  Created by Илья Канищев on 16.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var mistakesLabel: UILabel!
    
    var words = [String]()
    var mistakesCount = 0 {
        didSet {
            mistakesLabel.text = "Mistakes: \(mistakesCount)"
        }
    }
    var guessedLetters = [Character]()
    var wordString = ""
    var wordAsArray = Array(String(repeating: "?", count: 8))

    override func viewDidLoad() {
        super.viewDidLoad()
        mistakesLabel.text = "Mistakes: 0"
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            if let self = self{
                self.loadWords()
                self.wordString = (self.words.randomElement())!
                print(self.wordString)
            } else {
                fatalError("self is not available")
            }
        }
        wordLabel.text = String(repeating: "?", count: 8)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guess", style: .plain, target: self, action: #selector(guessLetter))
    }
    
    func loadWords() {
        if let url = Bundle.main.url(forResource: "words", withExtension: "txt"){
            if let loadedWords = try? String(contentsOf: url) {
                words = loadedWords.components(separatedBy: "\n")
            } else {
                print("Failed to load words from file")
            }
        } else {
            print("URL not found")
        }
    }
    
    @objc func guessLetter() {
        let ac = UIAlertController(title: "Guess a letter", message: nil, preferredStyle: .alert)
        ac.addTextField{textField in
            textField.placeholder = "Input a single letter"
        }
        ac.addAction(UIAlertAction(title: "Guess", style: .default, handler: {[weak self, weak ac] _ in
            if let text = ac?.textFields?.first!.text {
                if text.count == 1 {
                    self?.processGuess(text.lowercased().first!)
                } else {
                    let errorAlertController = UIAlertController(title: "Error", message: "You should only enter one letter", preferredStyle: .alert)
                    errorAlertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self?.present(errorAlertController, animated: true)
                }
            }
        }))
        present(ac, animated: true)
    }
    
    func processGuess(_ letter: Character) {
        guard !guessedLetters.contains(letter) else {
            return
        }
        
        if !wordString.contains(letter) {
            mistakesCount += 1
            if mistakesCount == 7 {
                let ac = UIAlertController(title: "You lost", message: "The word was \"\(wordString)\"", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: restartGame))
                present(ac, animated: true)
            }
            return
        }
        
        for (position, character) in wordString.enumerated() {
            if letter == character {
                wordAsArray[position] = character
            }
        }
        let newLabel = String(wordAsArray)
        wordLabel.text = newLabel
        if newLabel == wordString {
            let ac = UIAlertController(title: "You won", message: "Congratulations!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .default, handler: restartGame))
            present(ac, animated: true)
        }
    }
    
    func restartGame(_ action: UIAlertAction) {
        wordString = words.randomElement()!
        wordAsArray = Array(String(repeating: "?", count: 8))
        wordLabel.text = String(repeating: "?", count: 8)
        mistakesCount = 0
        guessedLetters.removeAll(keepingCapacity: true)
    }
}

