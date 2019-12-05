//
//  KartRushViewController.swift
//  KartRush
//
//  Created by user148325 on 12/3/19.
//  Copyright © 2019 user148325. All rights reserved.
//

import UIKit

class KartRushViewController: UITabBarController {
    
    var player: Player!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        for vc in viewControllers! {
            if let typeController = vc as? StoreViewController {
                typeController.player = player
            }
            if let typeController = vc as? GarageViewController {
                typeController.player = player
            }
            if let typeController = vc as? PlayViewController {
                typeController.player = player
            }
            if let typeController = vc as? SocialTableViewController {
                typeController.player = player
            }
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let index = selectedIndex
        print(index)
        
    }

}
