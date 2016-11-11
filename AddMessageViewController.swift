//
//  AddMessageViewController.swift
//  SlapChat
//
//  Created by Joanna Tzu-Hsuan Huang on 11/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    
       let store = DataStore.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let context = store.persistentContainer.viewContext
    
        if let text = textField.text {
        
            let newMessage = Message(context: context)
            newMessage.content = text
            newMessage.createAt = NSDate()
            DataStore.sharedInstance.messages.append(newMessage)
            store.saveContext()
            store.fetchData()
            dismiss(animated: true, completion: nil)
        }
        
        
    }

}
