//
//  MovieListViewController.swift
//  Router
//
//  Created by Gaurang on 27/04/22.
//

import UIKit

class MovieListViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    private lazy var logoutButton = UIBarButtonItem(title: "Logout",
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(logout))
    
    // MARK: - Properties
    private let viewModel = MovieListViewModel()
    
    // MARK: - View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // ???: - Maintain the sequence, coz its may create an issue
        // 1
        setupView()
        // 2
        observeViewModelEvent()
        // 3
        viewModel.startSynching()
    }
    
    // MARK: - Other methods
    private func setupView() {
        navigationItem.title = "Movies"
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func observeViewModelEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else {
                return
            }
            switch event {
            case .loading:
                self.showLoading()
            case .updateDataModel:
                self.hideLoading()
            case .error(let message, let retryCallback):
                self.hideLoading()
                self.showErrorMessage(message, onRetry: retryCallback)
            }
            self.tableView.reloadData()
        }
    }
    
    @objc private func logout() {
        SessionManager.shared.logout()
    }
    
}

// MARK: - TableView dataSource and delegate
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_cell", for: indexPath)
        let movie = viewModel.movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieId = viewModel.movies[indexPath.row].id
        self.push(router: .movieDetail(movieId: movieId))
    }
    
}
