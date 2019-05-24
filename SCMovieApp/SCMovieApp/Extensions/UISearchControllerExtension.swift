//
//  UISearchControllerExtension.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit

extension UISearchController {

    var hairlineView: UIView? {
        guard let barBackgroundView = self.searchBar.superview?.subviews.filter({ String(describing: type(of: $0)) == "_UIBarBackground" }).first
            else { return nil }

        return barBackgroundView.subviews.filter({ $0.bounds.height == 1 / self.traitCollection.displayScale }).first
    }
}
