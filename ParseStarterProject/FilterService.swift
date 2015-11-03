//
//  FilterService.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Weintrub on 11/3/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class FilterService {
    
    private class func setupFilter (filterName: String, parameters: [String: AnyObject]?, image: UIImage) -> UIImage? {
        
        let image  = CIImage(image: image)
        let filter: CIFilter
        
        if let parameters = parameters{
            filter = CIFilter(name: filterName, withInputParameters: parameters)!
        } else {
            filter = CIFilter(name: filterName)!
        }
        
        filter.setValue(image, forKey: kCIInputImageKey)
        
        //create GPU context
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let myEaglContext = EAGLContext(API:EAGLRenderingAPI.OpenGLES2)
        let gpuContext =  CIContext(EAGLContext: myEaglContext, options: options)
        
        /*  
        LINE 1: what comes out of the filter
        LINE 2: when you draw in the context, makes context the same size
        LINE 3: take snapshot of that context and store it in cgImage
         */
        let outputImage = filter.outputImage
        let extent = outputImage!.extent
        let cgImage = gpuContext.createCGImage(outputImage!, fromRect: extent)
        
        //return the final image
        let finalImage = UIImage(CGImage: cgImage)
        
        return finalImage
    
        }
    
    /*
    filters are not thread safe so we want to implement a completion handler to avoid main thread
    -> send in filtered image, returns image
    */
    class func applyVintageEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        /* filterName = required
        displayName = yourChoice
        */
        
        let filterName = kFilter1
        let displayName = kFilter2
        
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        /* uses NSOperationQueue to send filter service back to view controller
        abstracts filter service away from main queue
        */
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
            }
        }
    
    class func applyBWEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        /* filterName = required
            displayName = yourChoice
        */
        
        let filterName = kFilter3
        
        let displayName = kFilter4
        
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        /* uses NSOperationQueue to send filter service back to view controller
        abstracts filter service away from main queue
        */
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
        
    }
    
    class func applyChromeEffect(image: UIImage, completion: (filteredImage: UIImage?, name: String) -> Void) {
        
        /* filterName = required
        displayName = yourChoice
        */
        
        let filterName = kFilter5
        
        let displayName = kFilter6
        
        let finalImage = self.setupFilter(filterName, parameters: nil, image: image)
        
        /* uses NSOperationQueue to send filter service back to view controller
        abstracts filter service away from main queue
        */
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            completion(filteredImage: finalImage, name: displayName)
        }
        
    }
    
}