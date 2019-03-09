//
//  AlertService.swift
//  Magic the Gathering PVP
//
//  Created by Bryan Rumsey on 3/4/19.
//  Copyright © 2019 Bryan Rumsey. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert() -> alertViewController {
        let storyboard = UIStoryboard(name: "alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! alertViewController
        return alertVC
    }
}
