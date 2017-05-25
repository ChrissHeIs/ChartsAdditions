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
    
    public var defaultValueFormatter : DefaultValueFormatter? {
        get {
            return self.valueFormatter as? DefaultValueFormatter
        }
    }
    
    open func addMarker(marker: UNTChartAxisMarker) {
        self.markers.append(marker)
    }
}
