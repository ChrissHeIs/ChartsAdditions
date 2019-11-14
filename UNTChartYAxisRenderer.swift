//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTChartYAxisRenderer: YAxisRenderer {
    
    public var markerFont = NSUIFont.systemFont(ofSize: 10.0)
    
    internal override func drawYLabels(
        context: CGContext,
        fixedPosition: CGFloat,
        positions: [CGPoint],
        offset: CGFloat,
        textAlign: NSTextAlignment) {
        
        super.drawYLabels(context: context, fixedPosition: fixedPosition, positions:positions, offset: offset, textAlign: textAlign)
        
        guard let yAxis = self.axis as? UNTChartYAxis else { return }
        
        for marker in yAxis.markers {
            if marker.enabled {
                self.drawMarker(marker: marker, context: context, fixedPosition: fixedPosition, offset: offset, textAlign: textAlign)
            }
        }
    }
    
    private func drawMarker(marker: UNTChartAxisMarker, context: CGContext, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment) {
        guard let yAxis = self.axis as? UNTChartYAxis,
            let transformer = self.transformer else { return }
        let valueToPixelMatrix = transformer.valueToPixelMatrix
        
        var point = CGPoint(x:0, y:CGFloat(marker.value))
        point = point.applying(valueToPixelMatrix)
        point.x = fixedPosition - 5
        point.y = point.y + offset
        ChartUtils.drawText(
            context: context,
            text: "              ",
            point: point,
            align: textAlign,
            attributes: [
                NSAttributedString.Key.backgroundColor: marker.backgroundColor,
                NSAttributedString.Key.font: markerFont,
                NSAttributedString.Key.foregroundColor: marker.textColor
            ]
        )
        let text = marker.text ?? (yAxis.valueFormatter?.stringForValue(marker.value, axis: yAxis) ?? String(marker.value))
        ChartUtils.drawText(
            context: context,
            text: text,
            point: point,
            align: textAlign,
            attributes: [
                NSAttributedString.Key.backgroundColor: marker.backgroundColor,
                NSAttributedString.Key.font: markerFont,
                NSAttributedString.Key.foregroundColor: marker.textColor
            ]
        )
    }
}
