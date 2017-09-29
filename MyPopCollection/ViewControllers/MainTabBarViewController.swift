//
//  MainTabBarViewController.swift
//  MyPopCollection
//
//  Created by Elisabete Sousa on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("STARTED")
        //ServiceMock.sharedInstance.parseItems()
        print("ENDED")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
