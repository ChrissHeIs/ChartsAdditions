//
//  UNTChartXAxisRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import Foundation

// Used for dynamic charts that incorporate adding new records to the beginning of the chart.
// Regular xAxis starts layouting it's labels from the beginning of the list. Therefore, if some lavbels are skipped
// due to width, when new records are added to the beginning the visible labels may change.
//  |                |--------|                   |                  |--------|
//  |                |     ** |                   |                  |     ** |
//  |                |  * *  *|                   |                  |  * *  *|
//  |                | * *    |                   |                  | * *    |
//  |                |*       |                   |                  |*       |
//  |              **|        |                   |**              **|        |
//  |**************  |--------|                   |  **************  |--------|
//  |100 104 108 112 116 120 124                  | 98 102 106 110 114 118 122 126
//   ^
//   Start point of labels calculation             Start point of labels calculation(label width is 3)
//
// The class below fixes this situation. It uses a fixed label anchor point as a starting point for labels displaying
//  |                |--------|                   |                  |--------|
//  |                |     ** |                   |                  |     ** |
//  |                |  * *  *|                   |                  |  * *  *|
//  |                | * *    |                   |                  | * *    |
//  |                |*       |                   |                  |*       |
//  |              **|        |                   |**              **|        |
//  |**************  |--------|                   |  **************  |--------|
//  |100 104 108 112 116 120 124                  96 100 104 108 112 116 120 124
//                            ^                                               ^
//                      axisLabelsAnchorX                               axisLabelsAnchorX

public class UNTChartXAxisRenderer: ChartXAxisRenderer {
    
    internal var axisLabelsAnchorX: Int = 0
    
    public var markerFont = NSUIFont.systemFontOfSize(10.0)
    
    public override func drawLabels(context context: CGContext, pos: CGFloat, anchor: CGPoint)
    {
        guard let xAxis = xAxis as? UNTChartXAxis else { return }
        
        if xAxis.values.count == 0 { return }
        
        let sequenceBeforeAnchor = self.axisLabelsAnchorX.stride(to: max(self.minX - 1, 0), by: -xAxis.axisLabelModulus)
        self.drawLabels(forSequence: sequenceBeforeAnchor, context: context, pos: pos, anchor: anchor)
        
        let sequenceAfterAnchor = self.axisLabelsAnchorX.stride(to: min(self.maxX + 1, xAxis.values.count), by: xAxis.axisLabelModulus)
        self.drawLabels(forSequence: sequenceAfterAnchor, context: context, pos: pos, anchor: anchor)
        
        for marker in xAxis.markers {
            if marker.enabled {
                self.drawMarker(marker, context: context, y: pos, textAlign: .Center)
            }
        }
    }
    
    
    internal func drawLabels
        <S: SequenceType where S.Generator.Element == Int>
        (forSequence indexSequence:S, context: CGContext, pos: CGFloat, anchor: CGPoint) {
        
        guard let xAxis = xAxis else { return }
        
        let paraStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paraStyle.alignment = .Center
        
        let labelAttrs = [NSFontAttributeName: xAxis.labelFont,
                          NSForegroundColorAttributeName: xAxis.labelTextColor,
                          NSParagraphStyleAttributeName: paraStyle]
        let labelRotationAngleRadians = xAxis.labelRotationAngle * ChartUtils.Math.FDEG2RAD
        
        let valueToPixelMatrix = transformer.valueToPixelMatrix
        
        var position = CGPoint(x: 0.0, y: 0.0)
        
        var labelMaxSize = CGSize()
        
        if (xAxis.isWordWrapEnabled)
        {
            labelMaxSize.width = xAxis.wordWrapWidthPercent * valueToPixelMatrix.a
        }
        
        for i in indexSequence
        {
            let label = xAxis.values[i]
            if (label == nil)
            {
                continue
            }
            
            position.x = CGFloat(i)
            position.y = 0.0
            position = CGPointApplyAffineTransform(position, valueToPixelMatrix)
            
            if (viewPortHandler.isInBoundsX(position.x))
            {
                let labelns = label! as NSString
                
                if (xAxis.isAvoidFirstLastClippingEnabled)
                {
                    // avoid clipping of the last
                    if (i == xAxis.values.count - 1 && xAxis.values.count > 1)
                    {
                        let width = labelns.boundingRectWithSize(labelMaxSize, options: .UsesLineFragmentOrigin, attributes: labelAttrs, context: nil).size.width
                        
                        if (width > viewPortHandler.offsetRight * 2.0
                            && position.x + width > viewPortHandler.chartWidth)
                        {
                            position.x -= width / 2.0
                        }
                    }
                    else if (i == 0)
                    { // avoid clipping of the first
                        let width = labelns.boundingRectWithSize(labelMaxSize, options: .UsesLineFragmentOrigin, attributes: labelAttrs, context: nil).size.width
                        position.x += width / 2.0
                    }
                }
                
                drawLabel(context: context, label: label!, xIndex: i, x: position.x, y: pos, attributes: labelAttrs, constrainedToSize: labelMaxSize, anchor: anchor, angleRadians: labelRotationAngleRadians)
            }
        }
    }
    
    private func drawMarker(marker: UNTChartAxisMarker, context: CGContext, y:CGFloat, textAlign: NSTextAlignment) {
        guard let xAxis = xAxis as? UNTChartXAxis else { return }
        let valueToPixelMatrix = transformer.valueToPixelMatrix
        
        let xIndex = Int(marker.value)
        let label = xAxis.values[xIndex]
        var point = CGPointMake(CGFloat(xIndex), 0)
        point = CGPointApplyAffineTransform(point, valueToPixelMatrix)
        point.y = y
        //point.y = point.y + offset
        ChartUtils.drawText(
            context: context,
            text: "              ",
            point: point,
            align: textAlign,
            attributes: [
                NSBackgroundColorAttributeName: marker.backgroundColor,
                NSFontAttributeName: markerFont,
                NSForegroundColorAttributeName: marker.textColor
            ]
        )
        let text = marker.text ?? label!//(xAxis.valueFormatter?.stringFromNumber(marker.value) ?? String(marker.value))
        ChartUtils.drawText(
            context: context,
            text: text,
            point: point,
            align: textAlign,
            attributes: [
                NSBackgroundColorAttributeName: marker.backgroundColor,
                NSFontAttributeName: markerFont,
                NSForegroundColorAttributeName: marker.textColor
            ]
        )
    }
}