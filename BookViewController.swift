//
//  BookViewController.swift
//  BookCollector
//
//  Created by Trent Hand on 3/20/17.
//  Copyright © 2017 Trent Hand. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
//    let's the user select something from the library or take a new photo'
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
    }

    @IBAction func addTapped(_ sender: Any) {
    }
    
    @IBAction func photosTapped(_ sender: Any) {
//        this is how you get pictures off of a user's phone'
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
//    function allowing the user to select the image and add it to a new book
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        bookImageView.image = image
//        we must dismiss the previous image to make this work
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func cameraTapped(_ sender: Any) {
    }
}
