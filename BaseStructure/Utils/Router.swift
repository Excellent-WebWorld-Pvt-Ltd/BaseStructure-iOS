//
//  Router.swift
//  Router
//
//  Created by Gaurang on 05/04/22.
//

import UIKit

typealias EmptyCloser = () -> Void

enum Router {
    case login
    case movieList
    case movieDetail(movieId: Int)
}

extension Router {
    var storyboard: UIStoryboard.Storyboard {
        switch self {
        case .movieList, .movieDetail:
            return .main
        case .login:
            return .auth
        }
    }
    
    var instance: UIViewController {
        switch self {
        case .movieList:
            let viewCtr: MovieListViewController = getViewController()
            return viewCtr
        case .login:
            let viewCtr: LoginViewController = getViewController()
            return viewCtr
        case .movieDetail(let movieId):
            let viewCtr: MovieDetailsViewController = getViewController()
            viewCtr.movieId = movieId
            return viewCtr
        }
    }
    
    func getViewController<T: UIViewController>() -> T {
        return UIStoryboard(storyboard: storyboard).instantiate()
    }
}

extension UIViewController {
    
    func push(router: Router) {
        self.navigationController?.pushViewController(router.instance, animated: true)
    }
    
    func present(router: Router) {
        self.present(router.instance, animated: true)
    }
    
    func goBack(animated: Bool = true) {
        if navigationController == nil || navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: animated)
        } else {
            navigationController?.popViewController(animated: animated)
        }
    }

    var hasMoreThanOneViewControllers: Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }

    func bindToNavigation(isHidden: Bool = false) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: self)
        navVC.isNavigationBarHidden = isHidden
        return navVC
    }
}
