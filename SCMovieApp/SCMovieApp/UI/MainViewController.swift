//
//  MainViewController.swift
//  SCMovieApp
//
//  Created by Amin Amjadi on 2019. 05. 24..
//  Copyright © 2019. Amin Amjadi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier = "movieCell"
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        setupNavigationBar()
    }

    private func addNavigationBarTitle() {
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
        label.backgroundColor = .clear
        label.font = UIFont(name: "Helvetica-Bold", size: 25)

        label.text = "Movies"
        label.numberOfLines = 1
        label.textColor = UIColor.greyishBrown()
        label.sizeToFit()
        label.textAlignment = .center

        self.navigationItem.titleView = label
    }

    private func setupNavigationBar() {
        setupSearchController()
        addNavigationBarTitle()
        if let bar = navigationController?.navigationBar {
            bar.barTintColor = .white
            bar.backgroundColor = .white
            bar.isTranslucent = false
            bar.shadowImage = UIImage()
        }
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? MovieTableViewCell else {
            return MovieTableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension MainViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}

extension MainViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
    }
}
