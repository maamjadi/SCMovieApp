//
//  MovieTableViewCell.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var describtion: UILabel!

    var data: Movie? {
        didSet {
            setupView()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let containerLayer = containerView.layer
        containerLayer.cornerRadius = 9
        containerLayer.applySketchShadow(color: UIColor.shadowColor(), alpha: 0.9, x: 0, y: 4, blur: 15, spread: 0)

        movieThumbnail.layer.cornerRadius = 9
    }

    private func setupView() {
        if let data = data {
            describtion.text = data.overView
            titleLabel.text = data.title
            starLabel.text = String(data.voteAverage)
            heartLabel.text = String(data.popularity)
            if let posterPathURL  = MovieHandler.shared.getImageURL(from: data.posterPath) {
                movieThumbnail.setImage(from: posterPathURL)
            }
        }
    }

}
