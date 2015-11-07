//
//  GalleryViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Weintrub on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    var parseObjects = [PFObject]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = FlexibleFlowLayout(columns: 2.0)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.pullImageFromParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullImageFromParse() {
        
        let query = PFQuery(className: "Images")
        query.whereKeyExists("image")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                self.parseObjects = objects
            }
        }
        
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parseObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let filterCell = collectionView.dequeueReusableCellWithReuseIdentifier("galleryCell", forIndexPath: indexPath) as! FilterPreviewCollectionViewCell
        
        let object = self.parseObjects[indexPath.row]
        
        if let file = object["image"] as? PFFile {
            
            file.getDataInBackgroundWithBlock({ ( data , error ) -> Void in
                if let data = data {
                    let image = UIImage(data: data)!
                    filterCell.imageView.image = image
                }
            })
        }
        
        return filterCell
    }


}
