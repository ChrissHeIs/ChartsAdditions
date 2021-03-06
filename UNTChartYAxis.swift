//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTChartYAxis: ChartYAxis, AxisMarkersStorage {
    var markers: [UNTChartAxisMarker] = []
    
    public func addMarker(marker: UNTChartAxisMarker) {
        self.markers.append(marker)
    }
}