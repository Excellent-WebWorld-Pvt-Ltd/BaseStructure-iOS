//
//  UIImageView+Extension.swift
//  Populaw
//
//  Created by Gaurang on 23/11/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    enum Placeholder {
        case profile
        case app
        case custom(image: UIImage?)
        case none
    }
    
    func setImage(withPath path: String?, placeholder: Placeholder = .app) {
        setImage(withUrlString: path?.byAddingImageBasePath(), placeholder: placeholder)
    }
    
    func setImage(withUrlString urlString: String?, placeholder: Placeholder = .app) {
        let placeholderImage: UIImage? = {
            switch placeholder {
            case .profile:
                return UIImage(appImage: .profilePlaceholder)
            case .app:
                return UIImage(appImage: .placeholder)
            case .custom(let image):
                return image
            case .none:
                return nil
            }
        }()
        if let urlString = urlString, let url = URL(string: urlString) {
            print(urlString)
            self.kf.setImage(with: url, placeholder: placeholderImage, options: [.transition(.fade(1))])
        } else {
            self.image = placeholderImage
        }
    }
}
