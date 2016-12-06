//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Rafael Nicoleti on 30/11/16.
//  Copyright © 2016 Rafael Nicoleti. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var txtTitle: CustomTextField!
    @IBOutlet weak var txtPrice: CustomTextField!
    @IBOutlet weak var txtDetails: CustomTextField!
    @IBOutlet weak var thumbImg: UIImageView!
    
    var stores = [Store]()
    
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let itemTop = self.navigationController?.navigationBar.topItem {
            itemTop.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        //generateDataTest()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            txtTitle.text = item.title
            txtPrice.text = "\(item.price)"
            txtDetails.text = item.details
            thumbImg.image = item.toimage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
        
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
    func getStores() {
        let fecthRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
    
        do {
            
            try self.stores = context.fetch(fecthRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error)")
        }

    }
    
    
    func generateDataTest() {
        let store = Store(context: context)
        store.name = "BestBuy"

        let store1 = Store(context: context)
        store1.name = "Azure"
        
        let store2 = Store(context: context)
        store2.name = "Amazon"
        
        let store3 = Store(context: context)
        store3.name = "iPhone's"
        
        let store4 = Store(context: context)
        store4.name = "Macbook's"
        
        appDelegate.saveContext()
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            appDelegate.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func saveItemAction(_ sender: Any) {
        saveItem()
    }
    
    @IBAction func addImage(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
    func saveItem() {
        let item = Item(context: context)
        let picture = Image(context: context)
        picture.image = thumbImg.image
        
        if let title = txtTitle.text {
            item.title = title
        }
        
        item.toimage = picture
        
        if let price = txtPrice.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = txtDetails.text {
            item.details = details
        }
        
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        appDelegate.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
}
