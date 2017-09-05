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
    
    var photo: PhotoInfo!
    var image: UIImage!
    var label = ""
    var credit = ""
    
    func initData(forPhoto: PhotoInfo) {
        self.image = photo.image
        self.label = (photo.title as? String) ?? ""
        self.credit = (photo.owner as? String) ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = image
        titleLbl.text = label
        creditLbl.text = "Photo credit: \(String(describing: credit))"
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
