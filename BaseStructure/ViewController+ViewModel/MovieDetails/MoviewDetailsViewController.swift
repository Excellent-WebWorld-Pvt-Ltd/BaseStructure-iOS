//
//  MovieDetailsViewController.swift
//  BaseStructure
//
//  Created by Gaurang on 03/05/22.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: ThemeLabel!
    @IBOutlet weak var overviewLabel: ThemeLabel!
    
    // MARK: - Parameters
    var movieId: Int = -1
    
    // MARK: - Properties
    private lazy var viewModel = MovieDetailsViewModel(movieId)
    
    // MARK: - View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        observeViewModelEvent()
        viewModel.startSynching()
    }
    
    // MARK: - Other methods
    private func setupView() {
        navigationItem.title = "Loading..."
        posterImageView.layer.cornerRadius = 6
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
                self.setMovieInfo()
            case .error(let message, let retryCallback):
                self.hideLoading()
                self.showErrorMessage(message, onRetry: retryCallback)
            }
        }
    }
    
    private func setMovieInfo() {
        guard let info = self.viewModel.movieInfo else {
            self.goBack()
            return
        }
        navigationItem.title = info.title
        titleLabel.text = info.title
        posterImageView.setImage(withPath: info.posterPath, placeholder: .app)
        overviewLabel.text = info.overview
    }
}
