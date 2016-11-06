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
    
}
