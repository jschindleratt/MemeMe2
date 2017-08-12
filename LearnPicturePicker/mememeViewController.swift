//
//  ViewController.swift
//  LearnPicturePicker
//
//  Created by Joshua Schindler on 7/10/17.
//  Copyright © 2017 Joshua Schindler. All rights reserved.
//

import UIKit

class mememeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let TopDelegate = TopTextFieldDelegate()
    let BottomDelegate = BottomTextFieldDelegate()

    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -1]


    
    @IBOutlet weak var vcPictures: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cameraBUtton: UIBarButtonItem!
   
    @IBOutlet weak var txtTop: UITextField!
    @IBOutlet weak var txtBottom: UITextField!
    
    @IBOutlet weak var topNavBar: UINavigationBar!
    @IBOutlet weak var botToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtTop.delegate = TopDelegate
        self.txtBottom.delegate = BottomDelegate

        styleButtons(btn: txtTop, txt: "TOP")
        styleButtons(btn: txtBottom, txt: "BOTTOM")
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        vcPictures.image = nil
        txtTop.text = "TOP"
        txtBottom.text = "BOTTOM"
        saveButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraBUtton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            vcPictures.image = image
            saveButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        saveButton.isEnabled = false
    }

    @IBAction func pickAnIamge(_ sender: Any) {
        dispPicker(src: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        dispPicker(src: .camera)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if txtBottom.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func LaunchActivityView(_ sender: Any) {
        print("LaunchActivityView")
        let MemeImage:UIImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [MemeImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(controller, animated: true, completion:nil)
    }

    func save() {
        let meme = Meme(topText: txtTop.text!, bottomText: txtBottom.text!, originalImage: vcPictures.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {
        topNavBar.isHidden = true
        botToolBar.isHidden = true

        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topNavBar.isHidden = false
        botToolBar.isHidden = false
        
        return memedImage
    }
    
    func styleButtons(btn: UITextField, txt: String) {
        btn.defaultTextAttributes = memeTextAttributes
        btn.text = txt
        btn.textAlignment = NSTextAlignment.center
    }
    
    func dispPicker(src: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = src
        present(imagePicker, animated: true, completion: nil)

    }

}
