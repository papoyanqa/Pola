//
//  Effect.swift
//  PolaPic
//
//  Created by Gagik Papoyan on 8/7/16.
//  Copyright © 2016 Gagik Papoyan. All rights reserved.
//

import UIKit

class Effect: UIViewController, UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var pickedImage: UIImageView!
   
    
    
    let filtersCount = 10
    var tableData: [String] = ["None", "Mono", "Chrome", "Fade", "Instant", "Noir", "Process", "Sepia", "Transfer", "Vignette"]
    let context = CIContext(options: nil)
    
    override func viewDidLoad() {
        pickedImage.frame = CGRect(origin: CGPointZero, size: editImage!.size)
        pickedImage.image = editImage
        self.scrollview.minimumZoomScale = 1.0
        self.scrollview.maximumZoomScale = 7.0
        scrollview.delegate = self
            }
    
    @IBAction func effectBtn(sender: AnyObject) {
        // Create image to filter
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let inputImage = CIImage(image: self.pickedImage.image!)
            let filteredImage = inputImage!.imageByApplyingFilter("CIPhotoEffectNoir", withInputParameters: nil)
            let renderedImage = self.context.createCGImage(filteredImage, fromRect: filteredImage.extent)
            dispatch_async(dispatch_get_main_queue()) {
                self.pickedImage.image = UIImage(CGImage: renderedImage)
            }
        }
    }
    internal var editImage: UIImage!

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return pickedImage
    }
    

}



    