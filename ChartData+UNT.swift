//
//  ChartData+UNT.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

private var axisLabelsAnchorXAsociationKey = "axisLabelsAnchorXAsociationKey"

public extension ChartData {
    
    open var xValCount: Int {
        get {
            return self.dataSets.first?.entryCount ?? 0
        }
    }
//    func insertXVals(xVals: [String], atIndex index: Int) {
//        var indexOfNextObjectToInsert = index
//        for xVal in xVals {
//            self.xVals.insert(xVal, atIndex: indexOfNextObjectToInsert)
//            indexOfNextObjectToInsert += 1
//        }
//        
//        
//    }
    
    internal var axisLabelsAnchorX: Int {
        get {
            return (self.dataSets.first as? ChartDataSet)?.axisLabelsAnchorX ?? 0
        }
    }
}

public extension ChartDataSet {
    func insertYVals(yVals: [ChartDataEntry], atIndex index: Int) {
        self.willChangeValue(forKey: "yVals")
        
        var newValues = entries
        newValues.insert(contentsOf: yVals, at: index)
        replaceEntries(newValues)
        let indexOfNextObjectToInsert = index + yVals.count
        
        let recordsToShiftCount = self.entries.count - indexOfNextObjectToInsert;
        if recordsToShiftCount != 0 {
            let shiftDelta = yVals.count
            for i in indexOfNextObjectToInsert...self.entries.count - 1 {
                self.entries[i].x += Double(shiftDelta)
            }
        }
        
        if (self.axisLabelsAnchorX == 0) && (yVals.count != 0) {
            self.axisLabelsAnchorX = yVals.count - 1
        }
        else if index <= axisLabelsAnchorX {
            axisLabelsAnchorX += yVals.count
        }
        
        self.didChangeValue(forKey: "yVals")
    }
    
    internal var axisLabelsAnchorX: Int {
        get {
            return objc_getAssociatedObject(self, &axisLabelsAnchorXAsociationKey) as? Int ?? 0
        }
        set(newValue) {
            objc_setAssociatedObject(self, &axisLabelsAnchorXAsociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
