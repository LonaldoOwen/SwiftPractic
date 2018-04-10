//
//  Model.swift
//  KVOPractice
//
//  Created by owen on 07/04/2018.
//  Copyright © 2018 owen. All rights reserved.
//

import Foundation

class Person: NSObject {
    
    // store properties
    var firstName: String
    var lastName: String
    var account: Account?
    
    
    // computed properties
    var fullName: String {
        return firstName + " " + lastName
    }
    
    // initializer
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    // deinitializer
    deinit {
        print("#Person: deinit")
    }
}


/**
 问题：开始不加@objcMembers报错，后来去了又不报了？？？
 */
class Account: NSObject {
    
    // store properties
    @objc dynamic var balance: Double     // observed property
    var interestRate: Double
    
    // initializer
    init(balance: Double, interestRate: Double) {
        self.balance = balance
        self.interestRate = interestRate
    }
    
    // deinitializer
    deinit {
        print("#Account: deinit")
    }
}



/// Swift4 using KVO（Apple示例用法）
/// 注意：
/// 1、Swift4中observer使用了closure，unregister observer变为非必须；
/// 2、instance销毁前也不必须unregister observer
/// 3、KVO在OC中是dynamic用法，Swift中本身不具备runtime那套机制，因此，使用时要加@objc dynamic
/// 4、Swift中的class如果想使用KVO，class必须继承NSObject
///
///

// 1.Add the dynamic modifier and @objc attribute to any property you want to observe. For more information on dynamic
class MyObjectToObserve: NSObject {
    @objc dynamic var myDate = NSDate()
    
    func updateDate() {
        myDate = NSDate()
    }
    
}

// 2.Create an observer for the key path and call the observe(_:options:changeHandler) method. For more information on key paths
class MyObserver: NSObject {
    @objc var objectToObserve: MyObjectToObserve
    var observation: NSKeyValueObservation?
    
    init(object: MyObjectToObserve) {
        objectToObserve = object
        super.init()
        
        observation = observe(\.objectToObserve.myDate) { object, change in
            print("Observed a change to \(object.objectToObserve).myDate, updated to: \(object.objectToObserve.myDate)")
        }
        
        /**
         问题：未调用super.init()，直接调用self，报“'self' used before super.init call”
         原因：An initializer cannot call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
        */
        //print(self) // 'self' used before super.init call
    }
}










