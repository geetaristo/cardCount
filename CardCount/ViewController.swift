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
    
    var deckOfCards:Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputCount.inputAccessoryView = AccessoryToolBar()
        deckOfCards = Set(Dealer.sharedInstance.shuffle())
        
        cardLabel.text = deckOfCards.popFirst()

        runningCount += Dealer.sharedInstance.getHighLowValue(cardLabel.text!)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "dealNextCard")
        swipeRight.direction = .Right
        self.view.addGestureRecognizer(swipeRight)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkCount(sender: AnyObject) {
        var message = ""
        if Int(inputCount.text!) == runningCount {
            message = "Correct the count is \(runningCount)"
        } else {
            message = "Incorrect the count is \(runningCount)"
        }
        
        let alertController:UIAlertController = UIAlertController(title: "Count", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func shuffleDeck(sender: AnyObject) {
        deckOfCards = Set(Dealer.sharedInstance.shuffle())
        cardLabel.text = deckOfCards.popFirst()
        runningCount = 0
        runningCount += Dealer.sharedInstance.getHighLowValue(cardLabel.text!)
    }

    func dealNextCard() {
        cardLabel.text = deckOfCards.popFirst()
        runningCount += Dealer.sharedInstance.getHighLowValue(cardLabel.text!)
    }
}

