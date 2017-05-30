//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTChartYAxis: YAxis, AxisMarkersStorage {
    var markers: [UNTChartAxisMarker] = []
    
    public var defaultValueFormatter : DefaultAxisValueFormatter? {
        get {
            return self.valueFormatter as? DefaultAxisValueFormatter
        }
    }
    
    open func addMarker(marker: UNTChartAxisMarker) {
        self.markers.append(marker)
    }
}

public extension DefaultAxisValueFormatter {
    open var decimalDigits : Int {
        // Used for complience with ObjC (It can't use optional int)
        get {
            return self.decimals ?? 0
        }
        set {
            self.decimals = newValue
        }
    }
}
