//
//  ZoomableImageView.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/5/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ZoomableImageView: UIScrollView, UIScrollViewDelegate {
    
    fileprivate let imageView: UIImageView
    
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: frame)
        super.init(frame: frame)
        self.customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.imageView = UIImageView(frame: CGRect.zero)
        super.init(coder: aDecoder)
        self.customInit()
    }
    
    func customInit() {
        
        self.addSubview(imageView)
        
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 15.0
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false
        self.bouncesZoom = true
        self.decelerationRate = UIScrollViewDecelerationRateFast
        self.delegate = self
        
        // Where this method is being called is important
        setZoomScale()
        
        loadImage(image: UIImage(named: "Jacopo")!)
        
        guard let image = imageView.image else {
            return
        }
        
        self.imageView.frame = CGRect(origin: CGPoint.zero, size: image.size)
        setZoomScale()
        self.contentSize = image.size
    
        
        let imageCenter = CGPoint(x: image.size.width/2, y: image.size.height/2)
        self.contentOffset = imageCenter
        
    }
    
    
    func setZoomScale() {
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = self.bounds.size
        let widthScale = scrollViewSize.width/imageViewSize.width
        let heightScale = scrollViewSize.height/imageViewSize.height
        let minScale = min(widthScale, heightScale)
        
        self.minimumZoomScale = minScale
        self.zoomScale = minScale
    
    }
    
    func loadImage(image: UIImage) {
        imageView.image = image
    }
    
    // UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = self.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
}
