//
//  CoreDataAccess.swift
//  Seapare
//
//  Created by Yuan Yao on 2016-11-06.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import Foundation
import GRDB
import UIKit

// The shared database queue.
var dbQueue: DatabaseQueue!

func CoreDataAccess(){
    

}

func setupDatabase(_ application: UIApplication) throws {
    
    // Connect to the database
    //let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .userDomainMask, true).first! as NSString
    //let databasePath = documentsPath.appendingPathComponent("seapare.db")
    //print("path: \(databasePath)")
    let path = Bundle.main.path(forResource: "seapare", ofType: "db")
    print("db file path: \(path!)")
    dbQueue = try DatabaseQueue(path: path!)
    dbQueue.setupMemoryManagement(in: application)
    print("Setup dbQueue \(dbQueue)")
    
}


    /*func getCellPhonesByKeyword(keyword: String) -> CellPhoneSearchResultsList{
    let phoneList = CellPhoneSearchResultsList()
    dbQueue.inDatabase { db in
        for row in Row.fetch(db, "SELECT * FROM phone_table pt left join device_type_table dtt on pt.device_type_id = dtt.device_type_id left join brand_table bt on bt.brand_id = pt.brand_id") {
            let phone = CellPhone()
            phone.devie_type_name = row.value(named: "dt.device_type_name")
            phone.devie_type_name = row.value(named: "name")
            phoneList.append(phone: phone)
        }
    }
    
    return phoneList
}*/
