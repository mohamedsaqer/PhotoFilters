//
//  ViewController.swift
//  Saqer Filters
//
//  Created by Mohamed Saqer on 2/18/19.
//  Copyright © 2019 Mohamed Saqer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var Fimage: UIImage?
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet var secondryMenu: UIView!
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 //       let image = UIImage(named: "sample")
        // Process the image!
//        let myRGBA = RGBAImage(image: image!)!.toUIImage()
//
//        let BW = GrayScale(image: image!)!.convertImageToBW(image: image!)
//
//
//        let ROSAY = Rosa(image: image!, factor: 555)?.toUIImage()
//        let GREENY = Rosa(image: image!, factor: -55)?.toUIImage()
//
//        let BROWNY = Penceil(image: image!)?.toUIImage()
//        let MYIMAGE = Brightness(image: image!, contrast: 0.35, brightness: 0.44)?.toUIImage()
//
//        Fimage = BW
        secondryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondryMenu.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
    }
    @IBAction func onFilter(_ sender: UIButton) {
        if(sender.isSelected){
            hideSeconryMenu()
            sender.isSelected = false
        }else{
            showSecondryMenu()
            sender.isSelected = true
        }
    }
    
    func showSecondryMenu(){
        view.addSubview(secondryMenu)
        
        let bottomConstraints = secondryMenu.bottomAnchor.constraint(equalTo: bottomMenu.topAnchor)
        let leftConstraints = secondryMenu.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstrains = secondryMenu.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightCOnstrains = secondryMenu.heightAnchor.constraint(equalToConstant: 44)
        NSLayoutConstraint.activate([bottomConstraints, leftConstraints, rightConstrains, heightCOnstrains])
        
        view.layoutIfNeeded()
        
        self.secondryMenu.alpha = 0
        UIView.animate(withDuration: 0.4){
            self.secondryMenu.alpha = 1.0
        }
    }
    
    func hideSeconryMenu (){
        UIView.animate(withDuration: 1.0, animations: {
            self.secondryMenu.alpha = 0
        }) {
            completed in
            if completed == true
            {
                self.secondryMenu.removeFromSuperview()
            }
        }
    }
}

