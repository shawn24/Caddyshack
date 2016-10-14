//
//  CellPhone.swift
//  Seapare
//
//  Created by xiaoyunpang on 2016-10-03.
//  Copyright © 2016 Yuan Yao. All rights reserved.
//

import Foundation

class CellPhone : Device{
    var phone_id : Int!
    var network_id : Int!
    var processor_id : Int!
    var cellphone_name : String!
    
    var price : Float!
    var screen_size : Float!
    var ppi : Int!
    var resolution : Int!
    var ram : Int!
    var capacity : Int!
    var device_size : String!
    var weight : Float!
    var power_capacity : Int!
    var camera_resolution : Int!

    var detachable_flag : Bool!
    var platform : String!
    var gps_flag : Bool!
    var bluetooth_flag : Bool!
    var nfc_flag : Bool!
    var memory_card_support_flag : Bool!
    var fingerprint_flag : Bool!
    var warranty : Int!
    var model : String!
    var network_obj : Network!
    
    func comparePrice(c : CellPhone) -> Float { return self.price - c.price }
    
    func compareScreenSize(c: CellPhone) -> Float { return self.screen_size - c.screen_size }
    
    func comparePPI(c : CellPhone) -> Int { return self.ppi - c.ppi }
    
    func compareResolution(c : CellPhone) -> Int { return self.resolution - c.resolution }
    
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
    
    func compareWeight(c : CellPhone) -> Float { return self.weight - c.weight }
    
    func comparePowerCapacity(c : CellPhone) -> Int { return self.power_capacity - c.power_capacity }
    
    func compareCamera(c : CellPhone) -> Int { return self.camera_resolution - c.camera_resolution }
}

