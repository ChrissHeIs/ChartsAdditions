//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTEmptySpaceAllowedHighlighter : CombinedHighlighter {
    
    override public func getHighlight(x x: CGFloat, y: CGFloat) -> ChartHighlight?
    {
        let xIndex = getXIndex(x)
        
        guard let selectionDetail = getSelectionDetail(xIndex: xIndex, y: y, dataSetIndex: nil),
            let dataSet = selectionDetail.dataSet
            else { return nil }
        
        var point = CGPoint()
        point.y = y
        
        self.chart!.getTransformer(dataSet.axisDependency).pixelToValue(&point)
        
        return ChartHighlight(xIndex: xIndex, value: Double(point.y), dataIndex: selectionDetail.dataIndex, dataSetIndex: selectionDetail.dataSetIndex, stackIndex: -1)
    }
}