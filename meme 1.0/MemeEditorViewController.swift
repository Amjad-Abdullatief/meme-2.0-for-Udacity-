//
//  MemeEditorViewController.swift
//  meme 1.0
//
//  Created by AMJAD - on 30/01/1441 AH.
//  Copyright © 1441 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate   {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var textFieldDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        textFieldAttributes(textField: topTextField)
        textFieldAttributes(textField: bottomTextField)
        shareButton.isEnabled = false

    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           subscribeToKeyboardNotifications()
           subscribeToHideKeyboardNotifications()
           cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()

    }
    
     // Code for Keyboard Adjustments
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func subscribeToHideKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isEditing {
           view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //  Text Attributes
    func textFieldAttributes(textField: UITextField)
    {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    
    func pickAnImage(fromSource: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = fromSource
        present(imagePicker, animated: true, completion: nil)
    }
    
     // Picking image
    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickAnImage(fromSource: .photoLibrary)
    }
    
    // add image from camera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickAnImage(fromSource: .camera)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage  {
            self.imagePickerView.image = selectedImage
            shareButton.isEnabled = true
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        // add it to th memes array on Application delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        //  Hide toolbar
        toolBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
//       Show toolbar a
        toolBar.isHidden = false
        
        return memedImage
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //    Sharing a Meme using an Activity View
    @IBAction func shareImage(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, completed, items, error in
            if completed{

                self.save(memedImage: image)
                self.navigationController?.popToRootViewController(animated: true)
                
            }
        }
        self.present(controller, animated: true, completion: nil)

        }
    }


