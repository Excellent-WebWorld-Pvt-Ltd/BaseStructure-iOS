//
//  MovieDetailsViewModel.swift
//  BaseStructure
//
//  Created by Gaurang on 03/05/22.
//

import Foundation

final class MovieDetailsViewModel: BaseViewModel {

    var movieInfo: MovieInfoModel?
    let movieId: Int
    
    init(_ movieId: Int) {
        self.movieId = movieId
    }
    
    override func startSynching() {
        super.startSynching()
        
        self.emit(.loading)
        typealias ApiResult = Result<MovieInfoModel, ApiError>
        
        ApiService.call(MovieServices.details(id: movieId)) { (result: ApiResult)  in
            switch result {
            case .success(let model):
                print(model)
                self.movieInfo = model
                self.emit(.updateDataModel)
            case .failure(let error):
                print(error.localizedDescription)
                var retryClosure: EmptyClosure?
                if error.canRetry {
                    retryClosure = {
                        self.startSynching()
                    }
                }
                self.emit(.error(message: error.localizedDescription, retryCallback: retryClosure))
            }
        }
    }
}
