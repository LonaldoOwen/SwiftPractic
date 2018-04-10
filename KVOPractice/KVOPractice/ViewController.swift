//
//  ViewController.swift
//  KVOPractice
//
//  Created by owen on 07/04/2018.
//  Copyright © 2018 owen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Properties
    var person: Person!
    var account: Account!
    var someOCInstence: SomeOCClass!
    var balanceObserverToken: Any?
    var nameObserverToken: Any?
    var observer: MyObserver!
    
    
    // Actions
    @IBAction func handleChangePerson(_ sender: Any) {
    }
    
    @IBAction func handlePersonSetToNil(_ sender: Any) {
        person = nil
        print(person)
    }
    
    @IBAction func handleDeinitPerson(_ sender: Any) {
    }
    
    @IBAction func handleChangeAccount(_ sender: Any) {
        account.balance = 0.6
        someOCInstence.name = "WangWu"
        print("#Change account: \(account.balance)")
    }
    
    @IBAction func handleAccountSetToNil(_ sender: Any) {
        account = nil
        print(account)
        observer = nil
    }
    
    @IBAction func handleDeinitAccount(_ sender: Any) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        account = Account.init(balance: 2.4, interestRate: 0.678)
        person = Person.init(firstName: "San", lastName: "Zhang")
        someOCInstence = SomeOCClass.init(name: "LiSi")
        person.account = account
        
        //
        addObserver()
        
        // Swift4 KVO
        let observed = MyObjectToObserve()
        observer = MyObserver(object: observed)
        observed.updateDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
        print("person: \(person!)")
        print("account: \(account!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Objective-C like observer
    func addObserver() {
        print("#addObserver")
        
        
        account.addObserver(self,
                            forKeyPath: #keyPath(Account.balance),
                            options: [.new, .old],
                            context: &balanceObserverToken)
        print("#Add observer forKeyPath: #keyPath(Account.balance)")
        
//        someOCInstence.addObserver(self,
//                                   forKeyPath: #keyPath(SomeOCClass.name),
//                                   options: [.new, .old],
//                                   context: &nameObserverToken)
//        print("#Add observer forKeyPath: #keyPath(SomeOCClass.name)")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("#observeValue")
        
        // Only handle observations for the balanceObserverToken Context
//        guard context == &nameObserverToken else {
//            /// 如果设置了监听，却未进行处理，会进入此处；并报错
//            /// “*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '<KVOPractice.ViewController: 0x7feb0c40b5a0>: An -observeValueForKeyPath:ofObject:change:context: message was received but not handled.”
//            print("#context error!")
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//            return
//        }
        
        if context == &balanceObserverToken {
            print("#Handle obsereValue forKeyPath: #keyPath(Account.balance)")
            if keyPath == #keyPath(Account.balance) {
                print("#change: \(String(describing: change))")
            }
            
        } else if context == &nameObserverToken {
            print("#Handle obsereValue forKeyPath: #keyPath(SomeOCClass.name)")
            if keyPath == #keyPath(SomeOCClass.name) {
                print("# name")
                print("#change: \(String(describing: change))")
            }
            
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
    }

}

