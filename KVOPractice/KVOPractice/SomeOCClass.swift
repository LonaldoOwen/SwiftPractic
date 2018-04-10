//
//  SomeOCClass.swift
//  KVOPractice
//
//  Created by owen on 2018/4/7.
//  Copyright © 2018 owen. All rights reserved.
//

import UIKit

class SomeOCClass: NSObject {
    
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("#SomeOCClass: deinit")
    }

}
