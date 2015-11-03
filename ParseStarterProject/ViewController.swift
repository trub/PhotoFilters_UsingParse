/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            print("Object has been saved.")
        }
        
        self.view.backgroundColor = UIColor.yellowColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentImagePickerButtonSelected(sender: UIButton) {
        print("pressed")
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            let alertController = UIAlertController(title: "YOOOOO", message: "plz choose", preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) { (alert) -> Void in
                self.presentImagePicker(.Camera)
                
            }
            
            let photoLibrary = UIAlertAction(title: "Photos", style: UIAlertActionStyle.Default) { (alert) -> Void in
                self.presentImagePicker(.PhotoLibrary)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                
                let alertControllerTwo = UIAlertController(title: "Are you sure?", message: "don't go", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "WHATEVER MAN", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                    print("WHATEVER MAN")
                })
                
                
                alertControllerTwo.addAction(okAction)
                self.presentViewController(alertControllerTwo, animated: true, completion: nil)
            }
            
            
            alertController.addAction(photoLibrary)
            alertController.addAction(cameraAction)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            self.presentImagePicker(.PhotoLibrary)
            
        }
    
        
        
    }
    
    // present image picker
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    
    // UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        //dismiss picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        let imageSavedToParse = PFObject(className: kParseImages)
    
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            if let imageFile = PFFile(data: imageData) {
                imageSavedToParse["image"] = imageFile
                imageSavedToParse.saveInBackgroundWithBlock { (success, error) -> Void in
                    if success {
                        print("image has been uploaded to parse BOOYAH")
                    } else {
                        print("error")
                    }
                }
            }
        }
        
        
        // Convert to JPEG with 50% quality
//        var data: NSData = UIImageJPEGRepresentation(imageView.image, 0.5)
//        var imageFile: PFFile = PFFile(name: "Image.jpg", data: data)
//        
        //    let data = UIImageJPEGRepresentation(imageView.image, 0.5f);
        //    let imageFile = PFFile(name: "Image.jpg", data: data)
        
        // Save the image to Parse
//        imageFile.saveInBackgroundWithBlock({(succeeded: Bool, error: NSErrorPointer) in if !error {
//            var newPhotoObject: PFObject = PFObject.objectWithClassName("PhotoObject")
//            newPhotoObject.setObject(imageFile, forKey: "image")
//            newPhotoObject.saveInBackgroundWithBlock({(succeeded: Bool, error: NSErrorPointer) in            if !error {
//                print("saved")
//            }
//            else {
//                print("error",error)
//                }
//                
//            })
//            }
//            
//        })
//        
//    }
    
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }

    }

}







// create a class in parse

// Do any additional setup after loading the view, typically from a nib.

//        status[kStatusTextKey] = "Took this picture on my way to code fellows today. Seattle is awesome."
//        status["location"] = "Seattle"
//        status["hastags"] = "#beastMode"
//
//        status.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success {
//                print("Success saving to parse. Check parse console.")
//            }
//        }

