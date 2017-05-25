//
//  UNTChartHighlightRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import UIKit

public class UNTChartHighlightRenderer: Renderer {
//    
//    public var crosshairSize = CGFloat(40)
//    public var crosshairOffset = CGFloat(10)
//    
//    public var outlineColor: UIColor?
//    
//    public weak var dataProvider: CandleChartDataProvider?
//    public var animator: ChartAnimator?
//    
//    public init(dataProvider: CandleChartDataProvider?, animator: ChartAnimator?, viewPortHandler: ChartViewPortHandler)
//    {
//        super.init(viewPortHandler: viewPortHandler)
//        
//        self.animator = animator
//        self.dataProvider = dataProvider
//    }
//    
//    public func drawHighlighted(context context: CGContext, indices: [ChartHighlight])
//    {
//        guard let
//            candleData = dataProvider?.candleData,
//            let chartXMax = dataProvider?.chartXMax,
//            animator = animator
//            else { return }
//        
//        CGContextSaveGState(context)
//        
//        for high in indices
//        {
//            let minDataSetIndex = high.dataSetIndex == -1 ? 0 : high.dataSetIndex
//            let maxDataSetIndex = high.dataSetIndex == -1 ? candleData.dataSetCount : (high.dataSetIndex + 1)
//            if maxDataSetIndex - minDataSetIndex < 1 { continue }
//            
//            for dataSetIndex in minDataSetIndex..<maxDataSetIndex
//            {
//                guard let set = candleData.getDataSetByIndex(dataSetIndex) as? CandleChartDataSet else { continue }
//                
//                if !set.isHighlightEnabled
//                {
//                    continue
//                }
//                
//                CGContextSetStrokeColorWithColor(context, set.highlightColor.CGColor)
//                CGContextSetLineWidth(context, set.highlightLineWidth)
//                if (set.highlightLineDashLengths != nil)
//                {
//                    CGContextSetLineDash(context, set.highlightLineDashPhase, set.highlightLineDashLengths!, set.highlightLineDashLengths!.count)
//                }
//                else
//                {
//                    CGContextSetLineDash(context, 0.0, nil, 0)
//                }
//                
//                let xIndex = high.xIndex; // get the x-position
//                
//                if (CGFloat(xIndex) > CGFloat(chartXMax) * animator.phaseX)
//                {
//                    continue
//                }
//                
//                let yValue = high.value
//                if (yValue.isNaN)
//                {
//                    continue
//                }
//                
//                let y = CGFloat(yValue) * animator.phaseY; // get the y-position
//                
//                var point = CGPointZero
//                point.x = CGFloat(xIndex)
//                point.y = y
//                
//                let trans = dataProvider?.getTransformer(set.axisDependency)
//                
//                trans?.pointValueToPixel(&point)
//                
//                // draw outline
//                if let outlineColor = self.outlineColor {
//                    CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
//                    CGContextSetLineWidth(context, 1.5)
//                    drawCrossHair(context: context, point: point, set: set)
//                }
//                
//                // draw actual crosshair
//                CGContextSetStrokeColorWithColor(context, set.highlightColor.CGColor)
//                CGContextSetLineWidth(context, set.highlightLineWidth)
//                drawCrossHair(context: context, point: point, set: set)
//                
//                // draw the lines
//                drawHighlightLines(context: context, point: point, set: set)
//            }
//        }
//        
//        CGContextRestoreGState(context)
//    }
//    
//    public func drawHighlightLines(context context: CGContext, point: CGPoint, set: ILineScatterCandleRadarChartDataSet)
//    {
//        
//        // draw vertical highlight lines
//        if set.isVerticalHighlightIndicatorEnabled
//        {
//            CGContextBeginPath(context)
//            CGContextMoveToPoint(context, point.x, point.y + crosshairSize/2.0 + crosshairOffset)
//            CGContextAddLineToPoint(context, point.x, viewPortHandler.contentBottom)
//            CGContextStrokePath(context)
//            
//            CGContextBeginPath(context)
//            CGContextMoveToPoint(context, point.x, point.y - crosshairSize/2.0 - crosshairOffset)
//            CGContextAddLineToPoint(context, point.x, viewPortHandler.contentTop)
//            CGContextStrokePath(context)
//        }
//        
//        // draw horizontal highlight lines
//        if set.isHorizontalHighlightIndicatorEnabled
//        {
//            CGContextBeginPath(context)
//            CGContextMoveToPoint(context, point.x - crosshairSize/2.0 - crosshairOffset, point.y)
//            CGContextAddLineToPoint(context, viewPortHandler.contentLeft, point.y)
//            CGContextStrokePath(context)
//            
//            CGContextBeginPath(context)
//            CGContextMoveToPoint(context, point.x + crosshairSize/2.0 + crosshairOffset, point.y)
//            CGContextAddLineToPoint(context, viewPortHandler.contentRight, point.y)
//            CGContextStrokePath(context)
//        }
//    }
//    
//    public func drawCrossHair(context context: CGContext, point: CGPoint, set: ILineScatterCandleRadarChartDataSet)
//    {
//        // draw vertical highlight lines
//        if set.isVerticalHighlightIndicatorEnabled
//        {
//            CGContextBeginPath(context)
//            CGContextMoveToPoint(context, point.x, point.y - crosshairSize/2.0)
//            CGContextAddLineToPoint(context, point.x, point.y + crosshairSize/2.0)
//            CGContextStrokePath(context)
//        }
//        
//        // draw horizontal highlight lines
//        if set.isHorizontalHighlightIndicatorEnabled
//        {
//            CGContextBeginPath(context)
//            CGContextMoveToPoint(context, point.x - crosshairSize/2.0, point.y)
//            CGContextAddLineToPoint(context, point.x + crosshairSize/2.0, point.y)
//            CGContextStrokePath(context)
//        }
//    }
}
