//
//  CellPhone.swift
//  Seapare
//
//  Created by xiaoyunpang on 2016-10-03.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import Foundation

protocol Reflectable {
    func properties()->[String]
}

extension Reflectable
{
    func properties()->[String]{
        var s = [String]()
        for c in Mirror(reflecting: self).children
        {
            if let name = c.label{
                s.append(name)
            }
        }
        return s
    }
    
    func values()->[Any]{
        var a = [Any]()
        for c in Mirror(reflecting: self).children{
            a.append(c.value)
            
        }
        return a
    }
}

class CellPhone : Device, Reflectable {
    var phone_id : Int!
    var cellphone_name : String!
    var colour : String!
    var price : Float!
    var network : String!
    var screen_size : Float!
    var ppi : Int!
    var resolution : String!
    var ram : Int!
    var capacity : Int!
    var device_size : String!
    var camera_resolution : Float!
    var platform : String!
    var gps_flag : Bool!
    var bluetooth_flag : Bool!
    var nfc_flag : Bool!
    var memory_card_support_flag : Bool!
    var fingerprint_flag : Bool!
    var warranty : Int!
    var processor : String!
    var standby_hour : Int!
    var talktime_hour : Int!
    var weight : Int!
    
    func compareName(c : CellPhone) -> Bool { return self.cellphone_name < c.cellphone_name }
    
    func comparePrice(c : CellPhone) -> Float { return self.price - c.price }
    
    func compareScreenSize(c: CellPhone) -> Float { return self.screen_size - c.screen_size }
    
    func comparePPI(c : CellPhone) -> Int { return self.ppi - c.ppi }
    
    func compareRam(c : CellPhone) -> Int { return self.ram - c.ram }
    
    func compareCapacity(c : CellPhone) -> Int { return self.capacity - c.capacity }
    
    private func parse_size_string(_ size : String) -> Float {
        return size.components(separatedBy: "x")
            .map({(num : String) -> Float in return((num as NSString).floatValue)})
            .reduce(1, *)
    }
    
    func compareDeviceSize(c : CellPhone) -> Float {
        return parse_size_string(self.device_size) - parse_size_string(c.device_size)
    }
    
    func compareWeight(c : CellPhone) -> Int { return self.weight - c.weight }
    
    func compareCamera(c : CellPhone) -> Float { return self.camera_resolution - c.camera_resolution }
}

