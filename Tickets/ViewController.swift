//
//  ViewController.swift
//  Tickets
//
//  Created by Bryan Irace on 10/14/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let padding: CGFloat = 30
    private var textView: UITextView?
    private var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false);
        
        let textView = UITextView()
        textView.layer.borderColor = UIColor.redColor().CGColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 3
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(textView)
        
        self.textView = textView;
        
        let bottomConstraint = NSLayoutConstraint(item: textView,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Bottom,
            multiplier: 1,
            constant: -padding);
        
        self.view.addConstraints([
            NSLayoutConstraint(item: textView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top,
                multiplier: 1, constant: padding),
            bottomConstraint,
            NSLayoutConstraint(item: textView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right,
                multiplier: 1, constant: -padding),
            NSLayoutConstraint(item: textView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left,
                multiplier: 1, constant: padding)
            ])
        
        self.bottomConstraint = bottomConstraint
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // NOTE: Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<NSString, AnyObject> {
            let keyboardHeight = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size.height
            let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
            
            self.bottomConstraint?.constant = -padding - keyboardHeight
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            });
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<NSString, AnyObject> {
            let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
            
            self.bottomConstraint?.constant = -padding
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            });
        }
    }
}

