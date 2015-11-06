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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            print("project loaded")
        }
        
        self.view.backgroundColor = UIColor( hue: 0.2,
            saturation: 0.4,
            brightness: 1,
            alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: filter ==========================================================
    
    @IBAction func filterButtonPressed(sender: UIButton) {
        print("request to filter")
        //Add safety for image
        presentFilterAlert()
    }
    
    func presentFilterAlert () {
        
        //..
        self.performSegueWithIdentifier("FilterPreviewSegue", sender: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FilterPreviewSegue" {
            let previewImageViewController = segue.destinationViewController as! FiltersPreviewViewController
            //pass in the image from the image 
            previewImageViewController.image = self.imageView.image
            previewImageViewController.delegate = self
        }
    }
    
    
//    func presentFilterAlert(){
//        let alertController = UIAlertController(title: "Filters", message: "pick", preferredStyle: .ActionSheet)
//        
//        let vintageFilterAction = UIAlertAction(title: "Vintage", style: .Default) { (alert) -> Void in
//            
//            FilterService.applyVintageEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
//                
//                if let filteredImage = filteredImage{
//                    self.imageView.image = filteredImage
//                }
//                print("vintage")
//            })
//        }
//        
//        let BWFilterAction = UIAlertAction(title: "Black & White", style: .Default) { (alert) -> Void in
//            
//            FilterService.applyBWEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
//                
//                if let filteredImage = filteredImage{
//                    self.imageView.image = filteredImage
//                }
//                print("BW")
//            })
//        }
//        
//        
//        let chromeFilterAction = UIAlertAction(title: "Chrome", style: .Default) { (alert) -> Void in
//            
//            FilterService.applyChromeEffect(self.imageView.image!, completion: { (filteredImage, name) -> Void in
//                
//                if let filteredImage = filteredImage{
//                    self.imageView.image = filteredImage
//                }
//                print("Chrome")
//            })
//        }
//    
//    let cancelFilterAction = UIAlertAction(title: "cance", style: .Cancel, handler: nil)
//    
//    alertController.addAction(vintageFilterAction)
//    alertController.addAction(BWFilterAction)
//    alertController.addAction(chromeFilterAction)
//    alertController.addAction(cancelFilterAction)
//    
//    self.presentViewController(alertController, animated: true, completion: nil)
//        
//    }
    
    // end: filter ==========================================================

    //MARK: Image Picker Controller  ====================================================
    
    
    @IBAction func presentImagePickerButtonSelected(sender: UIButton) {
        print("request images")
        
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
    
    
    //UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        //resize image
        let resizedImage = UIImage.resizeImage(image, size: CGSize(width: 600, height: 600))
        self.imageView.image = resizedImage
        print("resize image to 600x600")
        
        //dismiss picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
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
    
    func filtersPreviewViewControllerDidFinish(image: UIImage) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    //end: Image Picker Controller  ====================================================
 
    
    //MARK: Upload Image Controller  ====================================================
    
    @IBAction func uploadImageParsePressed(sender: UIButton) {
        print("request to upload")
            
            let imageSavedToParse = PFObject(className: kParseImages)
            
            if let imageData = UIImageJPEGRepresentation(imageView.image!, 1.0) {
                if let imageFile = PFFile(data: imageData) {
                    imageSavedToParse["image"] = imageFile
                    imageSavedToParse.saveInBackgroundWithBlock { (success, error) -> Void in
                        if success {
                            print("image has been uploaded to parse BOOYAH")
//                            sender.enabled = true
                            //present user with success alert
                        } else {
                            print("error")
                        }
                    }
                }
            }
        
    
    
    //end: Upload Image Controller  ====================================================
    }


}


