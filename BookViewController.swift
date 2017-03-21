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

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
//    let's the user select something from the library or take a new photo'
    var imagePicker = UIImagePickerController()
    //setting up a test to see if the book is there.  if so, go to "Edit" options.  If not, we're going to add a book screen
    var book : Book? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        //determines what to do if the book object exists when this ViewController runs
        if book != nil {
            bookImageView.image = UIImage(data: book!.image as! Data)
            titleTextField.text = book!.title
            addUpdateButton.setTitle("Update", for: .normal)
        }else {
            deleteButton.isHidden = true
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        
        if book != nil {
            //if the book is already there, lets the user update the fields now
            book!.title = titleTextField.text
            book!.image = UIImagePNGRepresentation(bookImageView.image!) as NSData?
        } else {
            //saves the book into the CoreData Entity
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //creates the title and image attributes from the user inputs
            let book = Book(context: context)
            book.title = titleTextField.text
            book.image = UIImagePNGRepresentation(bookImageView.image!) as NSData?
        }
        

        //saves the new book in our array
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //returns us to the main ViewController after the new book is saved
        navigationController!.popViewController(animated: true)
    }
    
    //functionality when the user taps the Delete button
    @IBAction func deleteTapped(_ sender: Any) {
        //sets the book to be the one on the screen
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //deletes the book object
        context.delete(book!)
        //removes the book in our array
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //returns us to the main ViewController after the book is removed
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
