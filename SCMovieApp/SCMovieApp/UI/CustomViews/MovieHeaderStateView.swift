//
//  MovieHeaderStateView.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit

class MovieHeaderStateView: UIView {

    @IBOutlet var headerLabels: [UILabel]?

    @IBOutlet var dividerViews: [UIView]?
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    private let lightColor = UIColor(red: 195 / 255.0, green: 195 / 255.0, blue: 195 / 255.0, alpha: 1)

    override func layoutSubviews() {
        super.layoutSubviews()
        setColors()
    }

    private func setColors() {
        headerLabels?.forEach({ $0.textColor = lightColor })
        dividerViews?.forEach({ $0.backgroundColor = lightColor })

        statusLabel.textColor = UIColor.greyishBrown()
        popularityLabel.textColor = UIColor.greyishBrown()
        languageLabel.textColor = UIColor.greyishBrown()
    }

}
