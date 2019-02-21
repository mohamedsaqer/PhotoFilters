//
//  ViewController.swift
//  Saqer Filters
//
//  Created by Mohamed Saqer on 2/18/19.
//  Copyright © 2019 Mohamed Saqer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var Fimage: UIImage?
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet var secondryMenu: UIView!
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareButton.isEnabled = false
        secondryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondryMenu.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
    }
    
    func save(){
        guard let selectedImage = ImageView.image else{
            print("Imagee not Found")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, nil, nil)
    }
    @IBAction func onRosay(_ sender: UIButton) {
//        if(!sender.isSelected){
            compareButton.isEnabled = true
            ImageView.image = Rosa(image: Fimage!, factor: 555)?.toUIImage()
//            sender.isSelected = true
//        }else{
//            ImageView.image = Fimage
//            sender.isSelected = false
//        }
    }
    @IBAction func onGreeny(_ sender: Any) {
        compareButton.isEnabled = true
        ImageView.image = Rosa(image: Fimage!, factor: -55)?.toUIImage()
    }
    @IBAction func onBrowny(_ sender: Any) {
        compareButton.isEnabled = true
        ImageView.image = Penceil(image: Fimage!)?.toUIImage()
    }
    @IBAction func onGray(_ sender: Any) {
        compareButton.isEnabled = true
        ImageView.image = GrayScale(image: Fimage!)!.convertImageToBW(image: Fimage!)
    }
    @IBAction func onBrightness(_ sender: Any) {
        compareButton.isEnabled = true
        ImageView.image = Brightness(image: Fimage!, contrast: 0.35, brightness: 0.44)?.toUIImage()
    }
    @IBAction func onFilter(_ sender: UIButton) {
        Fimage = ImageView.image
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
        hideSeconryMenu()
        filterButton.isSelected = false
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
    @IBAction func onCompare(_ sender: UIButton) {
        if(!sender.isSelected){
            sender.isSelected = true
            ImageView.image = Fimage
        }else{
            sender.isSelected = false
            ImageView.image = GrayScale(image: Fimage!)!.convertImageToBW(image: Fimage!)
        }
    }
    
}

