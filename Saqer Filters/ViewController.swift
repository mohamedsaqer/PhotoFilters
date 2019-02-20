//
//  ViewController.swift
//  Saqer Filters
//
//  Created by Mohamed Saqer on 2/18/19.
//  Copyright © 2019 Mohamed Saqer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    @IBAction func onNewPhoto(_ sender: Any) {
        let ActionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        ActionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action in self.showCamera()}))
        ActionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: {action in self.showAlbum()}))
        ActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(ActionSheet, animated: true, completion: nil)
    }
    
    func showCamera(){
        let camarePicker = UIImagePickerController()
        camarePicker.delegate = self
        camarePicker.sourceType = .camera
        
        present(camarePicker, animated: true, completion: nil)
    }
    func showAlbum(){
        let camarePicker = UIImagePickerController()
        camarePicker.delegate = self
        camarePicker.sourceType = .photoLibrary
        
        present(camarePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
         ImageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onShare(_ sender: Any) {
       let activityControl = UIActivityViewController(activityItems: [ImageView.image!], applicationActivities: nil)
        present(activityControl, animated: true, completion: nil)
    }
    
}

