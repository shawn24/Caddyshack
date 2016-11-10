//
//  CellPhoneSearchResultList.swift
//  Seapare
//
//  Created by xiaoyunpang on 2016-10-14.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import Foundation



class CellPhoneSearchResultsList {
    
    var phones = [CellPhone]()
    
    func append(phone: CellPhone){
        phones.append(phone)
    }
    
    func getPhones() -> [CellPhone]{
        return phones
    }
    
    func sortByName(_ cellList : [CellPhone]) -> [CellPhone]{
        guard cellList.count > 1 else { return phones }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).cellphone_name < pivot.cellphone_name }
        let equal = cellList.filter { ($0).cellphone_name == pivot.cellphone_name }
        let right = cellList.filter { ($0).cellphone_name > pivot.cellphone_name }
        return sortByName(left) + equal + sortByName(right)
    }
    
}
