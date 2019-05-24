//
//  MovieDetailViewController.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieHeaderState: MovieHeaderStateView!
    @IBOutlet weak var movieTagView: TagView!

    var movieId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieHandler.shared.getMovie(with: movieId) { [weak self] (success, error, movie) in
            self?.movieTitle.text = movie?.title
            self?.starLabel.text = String(movie?.voteAverage ?? 0)
            if let posterPathURL = MovieHandler.shared.getImageURL(from: movie?.posterPath) {
                self?.MovieImage.setImage(from: posterPathURL)
            }
            self?.descriptionLabel.text = movie?.overView
            self?.movieHeaderState.data = movie
        }
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionLabel.textColor = UIColor.warmGrey()
    }

}
