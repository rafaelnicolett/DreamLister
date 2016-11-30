//
//  MainViewController.swift
//  DreamLister
//
//  Created by Rafael Nicoleti on 28/11/16.
//  Copyright © 2016 Rafael Nicoleti. All rights reserved.
//

import UIKit
import CoreData


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var fecthedResultsController : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //generateSeedData()
        attemptFetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fecthedResultsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fecthedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dreamListerCell", for: indexPath) as! DreamListerTableViewCell
        
        configureCell(itemCell: cell, indexPath: indexPath as IndexPath)
        
        return cell
    }
    
    func configureCell(itemCell: DreamListerTableViewCell, indexPath: IndexPath){
        
        let item = fecthedResultsController.object(at: indexPath)
        
        itemCell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func attemptFetch(){
        let fecthRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        fecthRequest.sortDescriptors = [dateSort]
        
        fecthedResultsController = NSFetchedResultsController(fetchRequest: fecthRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        do {
            
            try self.fecthedResultsController.performFetch()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! DreamListerTableViewCell
                configureCell(itemCell: cell, indexPath: indexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        default:
            break
        }
    }
    
    
    func generateSeedData(){
        let item = Item(context: context)
        
        item.title = "New Mac Book Pro"
        item.price = 2300
        item.details = "Lorem Ispum, Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum"
        
        let item1 = Item(context: context)
        
        item1.title = "iPhone 6s"
        item1.price = 1300
        item1.details = "Lorem Ispum, Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum"
        
        let item2 = Item(context: context)
        
        item2.title = "iPhone 7 Plus"
        item2.price = 2500
        item2.details = "Lorem Ispum, Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum"
        
        let item3 = Item(context: context)
        
        item3.title = "Tesla Motor"
        item3.price = 80000
        item3.details = "Lorem Ispum, Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum"
        
        let item4 = Item(context: context)
        
        item4.title = "Dell Latitude"
        item4.price = 1200
        item4.details = "Lorem Ispum, Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum Lorem Ispum"
        
        appDelegate.saveContext()
        
    }
    
    
    
    
    
    
    
    
}

