//
//  UIViewExtension.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    func xibSetup(
        xibName: String? = nil,
        inBundle bundle: Bundle = Bundle.main) {

        if let view = bundle.loadNibNamed(xibName ?? String(describing: type(of: self)),
                                          owner: self,
                                          options: nil)?[0] as? UIView {
            view.frame = bounds
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
