//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTChartXAxis: XAxis, AxisMarkersStorage {
    var markers: [UNTChartAxisMarker] = []
    
    public func addMarker(marker: UNTChartAxisMarker) {
        self.markers.append(marker)
    }
}

@objc(UNTChartXAxisDatesProvider)
public class UNTChartXAxisDatesProvider: NSObject, IAxisValueFormatter {
    var chartDataProvider: ChartDataProvider!
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dataSet = chartDataProvider.data?.dataSets.first else {
            return ""
        }
        
        return (dataSet.entryForIndex(Int(value))?.data as? String) ?? ""
    }
}
