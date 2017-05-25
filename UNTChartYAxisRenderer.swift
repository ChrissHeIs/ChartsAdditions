//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

public class UNTChartYAxisRenderer: YAxisRenderer {
    
//    public var markerFont = NSUIFont.systemFontOfSize(10.0)
//    
//    internal override func drawYLabels(context context: CGContext, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment) {
//        super.drawYLabels(context: context, fixedPosition: fixedPosition, offset: offset, textAlign: textAlign)
//        
//        guard let yAxis = yAxis as? UNTChartYAxis else { return }
//        
//        for marker in yAxis.markers {
//            if marker.enabled {
//                self.drawMarker(marker, context: context, fixedPosition: fixedPosition, offset: offset, textAlign: textAlign)
//            }
//        }
//    }
//    
//    private func drawMarker(marker: UNTChartAxisMarker, context: CGContext, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment) {
//        guard let yAxis = yAxis as? UNTChartYAxis else { return }
//        let valueToPixelMatrix = transformer.valueToPixelMatrix
//        
//        var point = CGPointMake(0, CGFloat(marker.value))
//        point = CGPointApplyAffineTransform(point, valueToPixelMatrix)
//        point.x = fixedPosition - 5.0
//        point.y = point.y + offset
//        ChartUtils.drawText(
//            context: context,
//            text: "              ",
//            point: point,
//            align: textAlign,
//            attributes: [
//                NSBackgroundColorAttributeName: marker.backgroundColor,
//                NSFontAttributeName: markerFont,
//                NSForegroundColorAttributeName: marker.textColor
//            ]
//        )
//        let text = marker.text ?? (yAxis.valueFormatter?.stringFromNumber(marker.value) ?? String(marker.value))
//        ChartUtils.drawText(
//            context: context,
//            text: text,
//            point: point,
//            align: textAlign,
//            attributes: [
//                NSBackgroundColorAttributeName: marker.backgroundColor,
//                NSFontAttributeName: markerFont,
//                NSForegroundColorAttributeName: marker.textColor
//            ]
//        )
//    }
}
