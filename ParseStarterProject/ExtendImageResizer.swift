//
//  ExtendImageResizer.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Weintrub on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        //draw image, start at top left, top right and make it the same size & width as starting image
        image.drawInRect(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        //take a snapshot of the photo we redrew
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        //we need to kill this so it doesn't live in memory forever
        UIGraphicsEndImageContext()
        
        return resizedImage
        
    }
}
