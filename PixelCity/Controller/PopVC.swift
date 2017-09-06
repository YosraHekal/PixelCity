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
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var creditLbl: UILabel!
    
    var selectedPhoto: PhotoInfo!

    func initData(forPhoto photo: PhotoInfo) {
        self.selectedPhoto = photo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = selectedPhoto.image
        titleLbl.text = selectedPhoto.title as! String
        creditLbl.text = "Photo credit: \(selectedPhoto.owner as! String)"
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
