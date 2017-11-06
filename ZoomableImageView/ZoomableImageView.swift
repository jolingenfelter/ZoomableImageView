//
//  ZoomableImageView.swift
//  MeWork
//
//  Created by Joanna LINGENFELTER on 11/5/17.
//  Copyright © 2017 JoLingenfelter. All rights reserved.
//

import UIKit

class ZoomableImageView: UIScrollView, UIScrollViewDelegate {
    
    fileprivate var imageView: UIImageView?
    public var imageSize: CGSize!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    func customInit() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 15.0
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bouncesZoom = true
        self.decelerationRate = UIScrollViewDecelerationRateFast
        self.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    private func setZoomScale() {
        
        guard let imageView = imageView else {
            return
        }
        
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = self.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        self.minimumZoomScale = min(widthScale, heightScale)
        self.zoomScale = 10.0
    }
    
    func showImage(image: UIImage) {
        
        if self.imageView != nil {
            self.imageView?.removeFromSuperview()
            self.imageView = nil
        }
        
        self.imageView = UIImageView(image: image)
        self.addSubview(imageView!)
        configureForImageSize(image.size)
        
    }
    
    private func configureForImageSize(_ imageSize: CGSize) {
        self.imageSize = imageSize
        self.contentSize = imageSize
        setZoomScale()
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let imageViewSize = imageView!.frame.size
        let scrollViewSize = self.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
}











