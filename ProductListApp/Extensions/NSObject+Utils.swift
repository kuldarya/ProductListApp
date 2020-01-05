//
//  NSObject+Utils.swift
//  TurkcellTechnicalAssignment
//
//  Created by Darya Kuliashova on 11/21/19.
//  Copyright © 2019 Darya Kuliashova. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
