//
//  MainSegueProtocol.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import Foundation
import UIKit

protocol MySegueProtocol{
    func getViewContainer(identifier:String) -> UIView
}

class MySegue: UIStoryboardSegue{
    
    override func perform() {
        let svc = self.source
        let dvc = self.destination
        
        svc.addChild(dvc)

        if let svcp = svc as? MySegueProtocol{
            let container = svcp.getViewContainer(identifier: self.identifier!)
            dvc.view.frame = container.frame
            dvc.view.frame.origin.x = 0
            dvc.view.frame.origin.y = 0
            container.addSubview(dvc.view)
        }
    }
}

