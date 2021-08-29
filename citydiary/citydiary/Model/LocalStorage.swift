//
//  LocalStorage.swift
//  citydiary
//
//  Created by Geraldo O Sales Jr on 29/08/21.
//

import CoreData
import UIKit

protocol LocalStorage {}

extension LocalStorage {
    var context: NSManagedObjectContext { (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext }
}
