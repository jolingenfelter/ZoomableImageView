//
//  ViewController.swift
//  ZoomableImageView
//
//  Created by Joanna LINGENFELTER on 11/5/17.
//  Copyright © 2017 Joanna LINGENFELTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cropBox = CropBox()
    let zoomableImageView = ZoomableImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        zoomableImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zoomableImageView)
        
        NSLayoutConstraint.activate([
            zoomableImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            zoomableImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zoomableImageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            zoomableImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
            ])
        
        view.addSubview(cropBox)
        cropBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cropBox.widthAnchor.constraint(equalTo: zoomableImageView.widthAnchor),
            cropBox.heightAnchor.constraint(equalTo: zoomableImageView.heightAnchor),
            cropBox.topAnchor.constraint(equalTo: zoomableImageView.topAnchor),
            cropBox.centerXAnchor.constraint(equalTo: zoomableImageView.centerXAnchor)
            ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        zoomableImageView.showImage(image: UIImage(named: "FierceReptile")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

