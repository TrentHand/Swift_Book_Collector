//
//  BookViewController.swift
//  BookCollector
//
//  Created by Trent Hand on 3/20/17.
//  Copyright © 2017 Trent Hand. All rights reserved.
//

import UIKit
import CoreData

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
        //saves the book into the CoreData Entity
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //creates the title and image attributes from the user inputs
        let book = Book(context: context)
        book.title = titleTextField.text
        book.image = UIImagePNGRepresentation(bookImageView.image!) as NSData?
        //saves the new book in our array
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //returns us to the main ViewController after the new book is saved
        navigationController!.popViewController(animated: true)
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
