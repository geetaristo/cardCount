//
//  ViewController.swift
//  CardCount
//
//  Created by Michael Luttrell on 11/18/15.
//  Copyright © 2015 Michael Luttrell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardLabel: UILabel!
    

    @IBOutlet weak var inputCount: UITextField!
    
    var runningCount = 0
    
    var deckOfCards:Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardLabel.layer.cornerRadius = 5
        cardLabel.layer.masksToBounds = true
        
        deckOfCards = Dealer.sharedInstance.shuffle()
        
        cardLabel.text = deckOfCards.removeFirst()

        runningCount += Dealer.sharedInstance.getHighLowValue(cardLabel.text!)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "dealNextCard")
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeRight)
        
        cardLabel.slideInFromLeft()
        inputCount.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkCount(sender: AnyObject) {
        var message = "", title = ""
        if Int(inputCount.text!) == runningCount {
            title = "Correct!"
            message = "The count is \(runningCount)"
        } else {
            title = "Incorrect"
            message = "You entered \(inputCount.text!) the count is \(runningCount)"
        }
        
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func shuffleDeck(sender: AnyObject) {
        deckOfCards = Dealer.sharedInstance.shuffle()
        runningCount = 0
        cardLabel.spin(0.25, completionDelegate: self)
    }

    func dealNextCard() {
        cardLabel.slideOutToRight(0.25, completionDelegate: self)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        guard deckOfCards.count != 0 else {
            cardLabel.text = "The End"
            cardLabel.slideInFromLeft()
            return
        }
        
        cardLabel.text = deckOfCards.removeFirst()
        runningCount += Dealer.sharedInstance.getHighLowValue(cardLabel.text!)
        cardLabel.slideInFromLeft()
    }
    
    func doneEditing() {
        inputCount.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

