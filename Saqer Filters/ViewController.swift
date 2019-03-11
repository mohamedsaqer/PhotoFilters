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
    var filtername = ""
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet var secondryMenu: UIView!
    @IBOutlet weak var bottomMenu: UIView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var overallyImageview: UIImageView!
    @IBOutlet weak var OriginalLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareButton.isEnabled = false
        secondryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondryMenu.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        ImageView.isUserInteractionEnabled = true
        Fimage = ImageView.image
        overallyImageview.isHidden = false
        overallyImageview.image = Fimage
        OriginalLabel.isHidden = false
    }
    

    @IBAction func onRosay(_ sender: UIButton) {
        compareButton.isEnabled = true
        compareButton.isSelected = false
        ImageView.image = Rosa(image: overallyImageview.image!, factor: 555)?.toUIImage()
        filtername = "rosay"
        overallyImageview.isHidden = true
        OriginalLabel.isHidden = true
        editButton.isEnabled = true
        editSlider.value = 1
    }
    @IBAction func onGreeny(_ sender: Any) {
        compareButton.isEnabled = true
        compareButton.isSelected = false
        ImageView.image = Rosa(image: overallyImageview.image!, factor: -55)?.toUIImage()
        filtername = "greeny"
        overallyImageview.isHidden = true
        OriginalLabel.isHidden = true
        editButton.isEnabled = true
        editSlider.value = 1
    }
    @IBAction func onBrowny(_ sender: Any) {
        compareButton.isEnabled = true
        compareButton.isSelected = false
        ImageView.image = Penceil(image: overallyImageview.image!)?.toUIImage()
        filtername = "browny"
        overallyImageview.isHidden = true
        OriginalLabel.isHidden = true
        editButton.isEnabled = true
        editSlider.value = 1
    }
    @IBAction func onGray(_ sender: Any) {
        compareButton.isEnabled = true
        compareButton.isSelected = false
        ImageView.image = GrayScale(image: overallyImageview.image!)!.convertImageToBW(image: Fimage!)
        filtername = "gray"
        overallyImageview.isHidden = true
        OriginalLabel.isHidden = true
        editButton.isEnabled = true
        editSlider.value = 1
    }
    @IBAction func onBrightness(_ sender: Any) {
        compareButton.isEnabled = true
        compareButton.isSelected = false
        ImageView.image = Brightness(image: overallyImageview.image!, contrast: 0.35, brightness: 0.44)?.toUIImage()
        filtername = "dark"
        overallyImageview.isHidden = true
        OriginalLabel.isHidden = true
        editButton.isEnabled = true
        editSlider.value = 1
    }
    @IBAction func onFilter(_ sender: UIButton) {
        Fimage = ImageView.image
        if(sender.isSelected){
            hideSeconryMenu()
            sender.isSelected = false
//            editSlider.isHidden = false
        }else{
            showSecondryMenu()
            sender.isSelected = true
            editSlider.isHidden = true
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
        compareButton.isSelected = false
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
         overallyImageview.image = image
         overallyImageview.isHidden = false
         OriginalLabel.isHidden = false
         Fimage = image
         hideSeconryMenu()
         filterButton.isSelected = false
         compareButton.isEnabled = false
         editSlider.isHidden = true
         editButton.isEnabled = false
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
            ImageView.image = overallyImageview.image
            overallyImageview.isHidden = false
            OriginalLabel.isHidden = false
        }else{
            overallyImageview.isHidden = true
            OriginalLabel.isHidden = true
            sender.isSelected = false
            switch filtername{
            case "rosay":
            ImageView.image = Rosa(image: Fimage!, factor: 555)?.toUIImage()
                break
            case "browny":
                ImageView.image = Penceil(image: Fimage!)?.toUIImage()
                break
            case "gray":
                ImageView.image = GrayScale(image: Fimage!)!.convertImageToBW(image: Fimage!)
                break
            case "greeny":
                ImageView.image = Rosa(image: Fimage!, factor: -55)?.toUIImage()
                break
            case "dark":
                ImageView.image = Brightness(image: Fimage!, contrast: 0.35, brightness: 0.44)?.toUIImage()
                break
            default:
                ImageView.image = Fimage
            }
        }
    }
    
    @IBAction func onTap(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UILongPressGestureRecognizer.State.began{
            ImageView.image = overallyImageview.image
            overallyImageview.isHidden = false
            OriginalLabel.isHidden = false
        }
        if recognizer.state == UILongPressGestureRecognizer.State.ended {
            if(compareButton.isEnabled){
                overallyImageview.isHidden = true
                OriginalLabel.isHidden = true
            switch filtername{
            case "rosay":
                ImageView.image = Rosa(image: Fimage!, factor: 555)?.toUIImage()
                break
            case "browny":
                ImageView.image = Penceil(image: Fimage!)?.toUIImage()
                break
            case "gray":
                ImageView.image = GrayScale(image: Fimage!)!.convertImageToBW(image: Fimage!)
                break
            case "greeny":
                ImageView.image = Rosa(image: Fimage!, factor: -55)?.toUIImage()
                break
            case "dark":
                ImageView.image = Brightness(image: Fimage!, contrast: 0.35, brightness: 0.44)?.toUIImage()
                break
            default:
                ImageView.image = Fimage
            }
        }
    }
  }
    @IBAction func onEdit(_ sender: UIButton) {
        filterButton.isSelected = false
        hideSeconryMenu()
        editSlider.isHidden = false
    }
    @IBAction func onSlider(_ sender: UISlider) {
        let o = Int(sender.value)
        switch filtername{
        case "rosay":
            ImageView.image = Rosa(image: Fimage!, factor: ( o ))?.toUIImage()
            break
        case "browny":
            ImageView.image = Penceil(image: overallyImageview.image!)?.toUIImage()
            break
        case "gray":
            ImageView.image = GrayScale(image: overallyImageview.image!)!.convertImageToBW(image: Fimage!)
            break
        case "greeny":
            ImageView.image = Rosa(image: overallyImageview.image!, factor: (o - 155) )?.toUIImage()
            break
        case "dark":
            ImageView.image = Brightness(image: overallyImageview.image!, contrast: ( (Double(o/60)) ), brightness: ( (Double(o/100)) ))?.toUIImage()
            break
        default:
            ImageView.image = Fimage
        }
    }
    
}

