//
//  ViewModel.swift
//  Router
//
//  Created by Gaurang on 27/04/22.
//

import Foundation

final class MovieListViewModel: BaseViewModel {

    var movies: [MovieInfoModel] = []
    
    override func startSynching() {
        super.startSynching()
        
        self.emit(.loading)
        typealias ApiResult = Result<BasePaginationModel<[MovieInfoModel]>, ApiError>
        
        ApiService.call(MovieServices.upcoming(page: 1)) { (result: ApiResult) in
            switch result {
            case .success(let model):
                self.movies = model.results ?? []
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
