//
//  UNTChartHighlightRenderer.swift
//  Pods
//
//  Created by Pavlo Shestak on 10/19/16.
//
//

import UIKit

public class UNTChartHighlightRenderer: Renderer {
    
    public var crosshairSize = CGFloat(40)
    public var crosshairOffset = CGFloat(10)
    
    public var outlineColor: UIColor?
    
    public weak var dataProvider: CandleChartDataProvider?
    public var animator: Animator?
    
    public init(dataProvider: CandleChartDataProvider?, animator: Animator?, viewPortHandler: ViewPortHandler)
    {
        super.init(viewPortHandler: viewPortHandler)
        
        self.animator = animator
        self.dataProvider = dataProvider
    }
    
    public func drawHighlighted(context: CGContext, indices: [Highlight])
    {
        guard let
            candleData = dataProvider?.candleData,
            let chartXMax = dataProvider?.chartXMax,
            let animator = animator
            else { return }
        
        context.saveGState()
        
        for high in indices
        {
            let minDataSetIndex = high.dataSetIndex == -1 ? 0 : high.dataSetIndex
            let maxDataSetIndex = high.dataSetIndex == -1 ? candleData.dataSetCount : (high.dataSetIndex + 1)
            if maxDataSetIndex - minDataSetIndex < 1 { continue }
            
            for dataSetIndex in minDataSetIndex..<maxDataSetIndex
            {
                guard let set = candleData.getDataSetByIndex(dataSetIndex) as? CandleChartDataSet else { continue }
                
                if !set.isHighlightEnabled
                {
                    continue
                }
                
                context.setStrokeColor(set.highlightColor.cgColor)
                context.setLineWidth(set.highlightLineWidth)
                if (set.highlightLineDashLengths != nil)
                {
                    context.setLineDash(phase: set.highlightLineDashPhase, lengths: set.highlightLineDashLengths!)
                }
                else
                {
                    context.setLineDash(phase: 0.0, lengths: [])
                }
                
                let xIndex = high.x; // get the x-position
                
                if (xIndex > chartXMax * animator.phaseX)
                {
                    continue
                }
                
                let yValue = high.y
                if (yValue.isNaN)
                {
                    continue
                }
                
                let y = yValue * animator.phaseY; // get the y-position
                
                var point = CGPoint.zero
                point.x = CGFloat(xIndex)
                point.y = CGFloat(y)
                
                let trans = dataProvider?.getTransformer(forAxis: set.axisDependency)
                
                trans?.pointValueToPixel(&point)
                
                // draw outline
                if let outlineColor = self.outlineColor {
                    context.setStrokeColor(UIColor.black.cgColor)
                    context.setLineWidth(1.5)
                    drawCrossHair(context: context, point: point, set: set)
                }
                
                // draw actual crosshair
                context.setStrokeColor(set.highlightColor.cgColor)
                context.setLineWidth(set.highlightLineWidth)
                drawCrossHair(context: context, point: point, set: set)
                
                // draw the lines
                drawHighlightLines(context: context, point: point, set: set)
            }
        }
        
        context.restoreGState()
    }
    
    public func drawHighlightLines(context: CGContext, point: CGPoint, set: ILineScatterCandleRadarChartDataSet)
    {
        guard let viewPortHandler = viewPortHandler else {
            return;
        }
        
        // draw vertical highlight lines
        if set.isVerticalHighlightIndicatorEnabled
        {
            context.beginPath()
            context.move(to: CGPoint(x: point.x, y: point.y + crosshairSize/2.0 + crosshairOffset))
            context.addLine(to: CGPoint(x: point.x, y:viewPortHandler.contentBottom))
            context.strokePath()
            
            context.beginPath()
            context.move(to: CGPoint(x: point.x, y: point.y - crosshairSize/2.0 - crosshairOffset))
            context.addLine(to: CGPoint(x: point.x, y:viewPortHandler.contentTop))
            context.strokePath()
        }
        
        // draw horizontal highlight lines
        if set.isHorizontalHighlightIndicatorEnabled
        {
            context.beginPath()
            context.move(to: CGPoint(x: point.x - crosshairSize/2.0 - crosshairOffset, y: point.y))
            context.addLine(to: CGPoint(x: viewPortHandler.contentLeft, y:point.y))
            context.strokePath()
            
            context.beginPath()
            context.move(to: CGPoint(x: point.x + crosshairSize/2.0 + crosshairOffset, y: point.y))
            context.addLine(to: CGPoint(x: viewPortHandler.contentRight, y:point.y))
            context.strokePath()
        }
    }
    
    public func drawCrossHair(context: CGContext, point: CGPoint, set: ILineScatterCandleRadarChartDataSet)
    {
        // draw vertical highlight lines
        if set.isVerticalHighlightIndicatorEnabled
        {
            context.beginPath()
            context.move(to: CGPoint(x: point.x, y: point.y - crosshairSize/2.0))
            context.addLine(to: CGPoint(x: point.x, y:point.y + crosshairSize/2.0))
            context.strokePath()
        }
        
        // draw horizontal highlight lines
        if set.isHorizontalHighlightIndicatorEnabled
        {
            context.beginPath()
            context.move(to: CGPoint(x: point.x - crosshairSize/2.0, y: point.y))
            context.addLine(to: CGPoint(x: point.x + crosshairSize/2.0, y:point.y))
            context.strokePath()
        }
    }
}
