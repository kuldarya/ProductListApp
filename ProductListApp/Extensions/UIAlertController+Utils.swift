//
//  UIAlertController+Utils.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/20/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showSettingsAlert(title: String, message: String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default, handler: { action -> Void in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(goToSettingsAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func showError(error: Error, controller: UIViewController) {
        showSettingsAlert(title: "Error Loading your data", message: error.localizedDescription, controller: controller)
    }
}
