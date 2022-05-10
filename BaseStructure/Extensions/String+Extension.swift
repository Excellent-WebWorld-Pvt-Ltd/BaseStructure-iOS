//
//  String+Extension.swift
//  Populaw
//
//  Created by Gaurang on 16/09/21.
//

import UIKit

extension String {
    
    func trimmed() -> Self {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isNotEmpty: Bool {
        return isEmpty == false
    }
    
    func byAddingImageBasePath() -> String {
        AppEnvironment.imageBasePath + self
    }
}

extension Array {
    var isNotEmpty: Bool {
        return count > 0
    }
}
