//
//  PopVC.swift
//  PixelCity
//
//  Created by Minni K Ang on 2017-09-01.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var popImageView: UIImageView!
    
    var poppedImage: UIImage!
    
    func initData(forImage image: UIImage) {
        self.poppedImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = poppedImage
        addDoubleTap()
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
