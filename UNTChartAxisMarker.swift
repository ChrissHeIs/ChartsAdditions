//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTChartAxisMarker : NSObject {
    public var value = 0.0
    public var text: String?
    public var backgroundColor = UIColor.clearColor()
    public var textColor = UIColor.whiteColor()
    
    public var enabled = true
}


protocol AxisMarkersStorage {
    var markers: [UNTChartAxisMarker] { get set }
    func addMarker(marker: UNTChartAxisMarker)
}