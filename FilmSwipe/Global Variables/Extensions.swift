//
//  Extensions.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/11.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: - ========ARRAY  EXTENSIONS ===========
//MARK: - ==String Array==
extension Array where Element == String {
    
    func asList()->List<String> {
        let list = List<String>()
        for str in self {
            list.append(str)
        }
        return list
    }
}

//MARK: - ========Image Related Extensions ===========
//MARK: - ==Image From String==
extension String {
    func image () -> UIImage {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let getImagePath = paths.appendingPathComponent(self)
        var image:UIImage = UIImage()
        if self != "" {
            if FileManager().fileExists(atPath: getImagePath) {
                
                image = UIImage(contentsOfFile: getImagePath)!
            }else {
                image = UIImage(named: "noImage.png")!
            }
        }else {
            image = UIImage(named: "noImage.png")!
        }
        return image
    }
}

//MARK: - ==Save Thumbnail==
extension UIImage {
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func saveAsPng(named name:String) {
        if let data = UIImagePNGRepresentation(self) {
            let filename = DocumentsDirectory.appendingPathComponent(name + ".png")
            try? data.write(to: filename)
        }
    }
}
