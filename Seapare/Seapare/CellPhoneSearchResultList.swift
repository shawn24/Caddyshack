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
        guard cellList.count > 1 else { return cellList }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).cellphone_name < pivot.cellphone_name }
        let equal = cellList.filter { ($0).cellphone_name == pivot.cellphone_name }
        let right = cellList.filter { ($0).cellphone_name > pivot.cellphone_name }
        return sortByName(left) + equal + sortByName(right)
    }
    
    func sortByBrand(_ cellList : [CellPhone]) -> [CellPhone]{
        guard cellList.count > 1 else { return cellList }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).brand_obj.brand_name < pivot.brand_obj.brand_name }
        let equal = cellList.filter { ($0).brand_obj.brand_name == pivot.brand_obj.brand_name }
        let right = cellList.filter { ($0).brand_obj.brand_name > pivot.brand_obj.brand_name }
        return sortByBrand(left) + equal + sortByBrand(right)
    }
    
    func sortByPrice(_ cellList : [CellPhone]) -> [CellPhone]{
        guard cellList.count > 1 else { return cellList }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).price < pivot.price }
        let equal = cellList.filter { ($0).price == pivot.price }
        let right = cellList.filter { ($0).price > pivot.price }
        return sortByPrice(left) + equal + sortByPrice(right)
    }
    
    func sortByCapacity(_ cellList : [CellPhone]) -> [CellPhone]{
        guard cellList.count > 1 else { return cellList }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).capacity < pivot.capacity }
        let equal = cellList.filter { ($0).capacity == pivot.capacity }
        let right = cellList.filter { ($0).capacity > pivot.capacity }
        return sortByCapacity(left) + equal + sortByCapacity(right)
    }
    
    func sortByRam(_ cellList : [CellPhone]) -> [CellPhone]{
        guard cellList.count > 1 else { return cellList }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).ram < pivot.ram }
        let equal = cellList.filter { ($0).ram == pivot.ram }
        let right = cellList.filter { ($0).ram > pivot.ram }
        return sortByRam(left) + equal + sortByRam(right)
    }
    
    func sortByCamera(_ cellList : [CellPhone]) -> [CellPhone]{
        guard cellList.count > 1 else { return cellList }
        
        let pivot = cellList[cellList.count/2]
        let left = cellList.filter { ($0).camera_resolution < pivot.camera_resolution }
        let equal = cellList.filter { ($0).camera_resolution == pivot.camera_resolution }
        let right = cellList.filter { ($0).camera_resolution > pivot.camera_resolution }
        return sortByCamera(left) + equal + sortByCamera(right)
    }
    
}
