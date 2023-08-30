//
//  UIView+Extension.swift
//  CatBreeds
//
//  Created by yunus oktay on 24.04.2022.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRaidus: CGFloat {
        get { return cornerRaidus }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
