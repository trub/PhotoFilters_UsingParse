//
//  FiltersPreviewViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Weintrub on 11/6/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate {
    
    func filtersPreviewViewControllerDidFinish(image: UIImage)
}

class FiltersPreviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var delegate : FiltersPreviewViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = FlexibleFlowLayout(columns: 3.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var image : UIImage?
    
    var filters = [FilterService.applyBWEffect, FilterService.applyChromeEffect, FilterService.applyVintageEffect]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let filterCell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterPreviewCell", forIndexPath: indexPath) as! FilterPreviewCollectionViewCell
        
        let filterFunction = self.filters[indexPath.row]
        
        if let image = self.image {
            
            filterFunction(image, completion: {(filteredImage, name) -> Void in
                filterCell.imageView.image = filteredImage
            })
            
        }
        
        return filterCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // fire anytime a user selections a collection view cell
        
        //
        if let delegate = self.delegate {
           
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterPreviewCollectionViewCell
            
            delegate.filtersPreviewViewControllerDidFinish(cell.imageView.image!)
        }
    }

}
