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
    func insertXVals(xVals: [String], atIndex index: Int) {
        var indexOfNextObjectToInsert = index
        for xVal in xVals {
            self.xVals.insert(xVal, atIndex: indexOfNextObjectToInsert)
            indexOfNextObjectToInsert += 1
        }
        
        if (self.axisLabelsAnchorX == 0) && (xVals.count != 0) {
            self.axisLabelsAnchorX = xVals.count - 1
        }
        else if index <= axisLabelsAnchorX {
            axisLabelsAnchorX += xVals.count
        }
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

public extension ChartDataSet {
    func insertYVals(yVals: [ChartDataEntry], atIndex index: Int) {
        self.willChangeValueForKey("yVals")
        var indexOfNextObjectToInsert = index
        for yVal in yVals {
            self.yVals.insert(yVal, atIndex: indexOfNextObjectToInsert)
            indexOfNextObjectToInsert += 1
        }
        
        let recordsToShiftCount = self.yVals.count - indexOfNextObjectToInsert;
        if recordsToShiftCount != 0 {
            let shiftDelta = yVals.count
            for i in indexOfNextObjectToInsert...self.yVals.count - 1 {
                self.yVals[i].xIndex += shiftDelta
            }
        }
        self.didChangeValueForKey("yVals")
    }
}