//
//  MimeTypes.swift
//  Populaw
//
//  Created by Gaurang on 02/12/21.
//

import Foundation
import UIKit

final class MimeTypes {

    var data: Data
    var mimeType: String
    var fileName: String
    var key: String

    init?(_ file: Any, key: String) {
        self.key = key
        var mimeType: String?
        var fileData: Data?
        var fileName = ""
        if let image = file as? UIImage {
            if let data = image.getData(inKb: 500) {
                fileData = data
                mimeType = "image/jpeg"
                fileName = "\(Helper.randomString(length: 10)).jpeg"
            }
        }
        if let unwrappedData = fileData, let unwrappedMimeType = mimeType {
            self.data = unwrappedData
            self.mimeType = unwrappedMimeType
            self.fileName = fileName
        } else {
            return nil
        }
    }

}

extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(kb expectedSizeInKb: Int) -> UIImage? {
        
        if let data = getData(inKb: expectedSizeInKb) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func getData(inKb expectedSizeInKb: Int) -> Data? {
        let sizeInBytes = expectedSizeInKb * 1024
        var needCompress: Bool = true
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        while needCompress && compressingValue > 0.0 {
            if let data: Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                    if compressingValue < 0 {
                        imgData = data
                        needCompress = false
                    }
                }
            }
        }
        return imgData
    }
}
