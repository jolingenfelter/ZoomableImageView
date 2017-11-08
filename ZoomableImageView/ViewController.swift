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
    
    lazy var cropButton: UIButton = {
        let button = UIButton()
        button.setTitle("Crop", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 1/255, green: 151/255, blue: 246/255, alpha: 1.0)
        button.addTarget(self, action: #selector(cropImage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func navBarSetup() {
        let resetButton = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(revertToOriginal))
        self.navigationItem.rightBarButtonItem = resetButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        zoomableImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(zoomableImageView)
        
        NSLayoutConstraint.activate([
            zoomableImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            zoomableImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            zoomableImageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            zoomableImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            ])
        
        view.addSubview(cropBox)
        cropBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cropBox.widthAnchor.constraint(equalTo: zoomableImageView.widthAnchor),
            cropBox.heightAnchor.constraint(equalTo: zoomableImageView.heightAnchor),
            cropBox.topAnchor.constraint(equalTo: zoomableImageView.topAnchor),
            cropBox.centerXAnchor.constraint(equalTo: zoomableImageView.centerXAnchor)
            ])
        
        view.addSubview(cropButton)
        cropButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cropButton.topAnchor.constraint(equalTo: zoomableImageView.bottomAnchor, constant: 80),
            cropButton.centerXAnchor.constraint(equalTo: zoomableImageView.centerXAnchor),
            cropButton.heightAnchor.constraint(equalToConstant: 40),
            cropButton.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    @objc func cropImage() {
        do {
            try zoomableImageView.cropImage(completion: { (image) in
               // Save image
            })
        } catch ImageCroppingError.unknownError {
            print(ImageCroppingError.unknownError.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func revertToOriginal() {
        zoomableImageView.revertToOriginal() 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        zoomableImageView.showImage(image: UIImage(named: "Jacopo")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

