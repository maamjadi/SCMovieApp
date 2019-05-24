//
//  MovieHeaderStateView.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit

class MovieHeaderStateView: UIView {

    @IBOutlet var headerLabels: [UILabel]!
    @IBOutlet var dividerViews: [UIView]!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    private let lightColor = UIColor(red: 195 / 255.0, green: 195 / 255.0, blue: 195 / 255.0, alpha: 1)

    var data: Movie? {
        didSet {
            setupViews()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(inBundle: Bundle(for: MovieHeaderStateView.self))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setColors()
    }

    func setupViews() {
        guard let movie = data else { return }
        languageLabel.text = movie.originalLanguage
        popularityLabel.text = String(movie.popularity)
        statusLabel.text = movie.status ?? "Unknown"
    }

    private func setColors() {
        headerLabels?.forEach({ $0.textColor = lightColor })
        dividerViews?.forEach({ $0.backgroundColor = lightColor })

        statusLabel.textColor = UIColor.greyishBrown()
        popularityLabel.textColor = UIColor.greyishBrown()
        languageLabel.textColor = UIColor.greyishBrown()
    }

}
