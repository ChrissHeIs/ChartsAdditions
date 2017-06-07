//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTEmptySpaceAllowedHighlighter : CombinedHighlighter {
    
    open override func getHighlight(x: CGFloat, y: CGFloat) -> Highlight? {
        guard let chart = self.chart as? BarLineScatterCandleBubbleChartDataProvider,
            let set = chart.data?.dataSets.first,
            let originalHighlight = super.getHighlight( x: x, y: y)
            else {
            return nil
        }
        let transformer = chart.getTransformer(forAxis: .right)
        var point = CGPoint(x: x, y: y)
        transformer.pixelToValues(&point)
        var highlight = Highlight(x: originalHighlight.x, y: Double(point.y), xPx:originalHighlight.xPx , yPx:y  , dataSetIndex: 0, stackIndex:-1, axis: set.axisDependency)
        return highlight
    }
}
